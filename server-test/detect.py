import os
import torch
import torchvision.transforms as transforms
from PIL import ImageGrab, Image
from torchvision.models.resnet import resnet50, ResNet, Bottleneck


# Load the trained model
def load_model(model_path):
    model = resnet50(weights=None)
    num_classes = 21
    model.fc = torch.nn.Linear(model.fc.in_features, num_classes)
    model.load_state_dict(
        torch.load(model_path, map_location=torch.device('cpu')))
    model.eval()
    return model


# Preprocess the input image
def preprocess_image(image):
    transform = transforms.Compose([
        transforms.Resize((224, 224)),
        transforms.ToTensor(),
        transforms.Normalize(mean=[0.485, 0.456, 0.406],
                             std=[0.229, 0.224, 0.225])
    ])
    return transform(image).unsqueeze(0)


# Predict the character name
def predict_character_name_and_confidence(model, image, class_names):
    input_tensor = preprocess_image(image)
    output = model(input_tensor)
    probabilities = torch.nn.functional.softmax(output, dim=1)
    max_prob, predicted_index = torch.max(probabilities, 1)
    confidence = max_prob.item() * 100
    return class_names[predicted_index.item()], confidence


# Load the class names
def load_class_names(dataset_folder):
    return sorted(os.listdir(dataset_folder))


#split image into segments
def split_image_into_segments(image, num_segments):
    width, height = image.size
    segment_width = width // num_segments
    segments = []

    for i in range(num_segments):
        left = i * segment_width
        top = 0
        right = (i + 1) * segment_width
        bottom = height
        segment = image.crop((left, top, right, bottom))
        segment.save(f"segment_{i}.png")
        segments.append(segment)

    return segments


def capture_and_save_first_segment(output_dir):
    # Capture the full screen
    screenshot = ImageGrab.grab()

    # Calculate the size of each segment
    width, height = screenshot.size
    segment_height = height // 10

    # Define the cropping coordinates for the first segment
    left = 0
    top = 0
    right = width
    bottom = segment_height

    # Crop the first segment
    first_segment = screenshot.crop((left, top, right, bottom))

    # Save the first segment
    output_path = os.path.join(output_dir, "agent_segment.png")
    first_segment.save(output_path)


# Example usage
def detectwithss():
    model_path = "character_classification_model.pth"
    data_dir = "./Agents/training"

    output_dir = "./screenshots"
    capture_and_save_first_segment(output_dir)

    image_path = "./screenshots/agent_segment.png"

    model = load_model(model_path)
    class_names = load_class_names(data_dir)
    # Load the input image and split it into segments
    input_image = Image.open(image_path).convert('RGB')
    num_segments = 27
    segments = split_image_into_segments(input_image, num_segments)

    # Predict the character's name for each segment
    character_names_and_confidences = [
        predict_character_name_and_confidence(model, segment, class_names)
        for segment in segments
    ]

    print("The detected characters are:")
    start1 = 6
    stop1 = 11
    start2 = 16
    stop2 = 21

    defenders = {}
    attackers = {}
    for i, (character_name, confidence) in enumerate(
            character_names_and_confidences[start1:stop1], start=start1):
        if confidence >= 50:
            print(f"{i}: {character_name} (Confidence: {confidence:.2f}%)")
            agents = character_name
        else:
            #print(f"{i}: Not identified (Confidence: {confidence:.2f}%)")
            agents = "nid"
        defenders[i - 5] = agents
    for i, (character_name, confidence) in enumerate(
            character_names_and_confidences[start2:stop2], start=start2):
        if confidence >= 50:
            #print(f"{i}: {character_name} (Confidence: {confidence:.2f}%)")
            agents = character_name
        else:
            #print(f"{i}: Not identified (Confidence: {confidence:.2f}%)")
            agents = "nid"
        attackers[i - 15] = agents

    #print(defenders)
    #print(attackers)

    return [defenders, attackers]


detectwithss()