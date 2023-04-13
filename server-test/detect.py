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
    model.load_state_dict(torch.load(model_path))
    model.eval()
    return model


# Preprocess the input image
def preprocess_image(image_path):
    transform = transforms.Compose([
        transforms.Resize((224, 224)),
        transforms.ToTensor(),
        transforms.Normalize(mean=[0.485, 0.456, 0.406],
                             std=[0.229, 0.224, 0.225])
    ])
    image = Image.open(image_path).convert('RGB')
    return transform(image).unsqueeze(0)


# Predict the character name
def predict_character_name(model, image_path, class_names):
    input_tensor = preprocess_image(image_path)
    output = model(input_tensor)
    probabilities = torch.nn.functional.softmax(output, dim=1)
    _, predicted_index = torch.max(probabilities, 1)
    return class_names[predicted_index.item()]


# Load the class names
def load_class_names(dataset_folder):
    return sorted(os.listdir(dataset_folder))


def capture_and_save_first_segment(output_dir):
    # Capture the full screen
    screenshot = ImageGrab.grab()

    # Calculate the size of each segment
    width, height = screenshot.size
    segment_width = width // 8

    # Define the cropping coordinates for the first segment
    left = 0
    top = 0
    right = segment_width
    bottom = height

    # Crop the first segment
    first_segment = screenshot.crop((left, top, right, bottom))

    # Save the first segment
    output_path = os.path.join(output_dir, "first_segment.png")
    first_segment.save(output_path)


# Example usage
if __name__ == "__main__":
    model_path = "character_classification_model.pth"
    data_dir = "./Agents/training"
    image_path = "test.jpg"

    model = load_model(model_path)
    class_names = load_class_names(data_dir)
    character_name = predict_character_name(model, image_path, class_names)

    output_dir = "path/to/output/directory"
    capture_and_save_first_segment(output_dir)

    print(f"The detected character is: {character_name}")
