import torch
from torchvision import transforms
from PIL import Image
import matplotlib.pyplot as plt
from model.src.model import Model

# Pfad zum Bild und zum gespeicherten Modell
image_path = 'model/test/test_data/IMG_3460.jpg'
model_path = 'model/best_model.pth'

class_names = ['blastoise', 'butterfree', 'charizard', 'dragonite', 'gengar', 'gyarados', 'pikachu', 'rhyhorn', 'slowbro', 'venusaur']

# Transformationspipeline für das Bild
transform = transforms.Compose([
    transforms.Resize((64, 64)),
    transforms.ToTensor(),
    transforms.Normalize(mean=[0.485, 0.456, 0.406], std=[0.229, 0.224, 0.225])
])

# Bild laden und transformieren
image = Image.open(image_path)
image = transform(image).unsqueeze(0)  

# Modell laden
model = Model()
model.load_state_dict(torch.load(model_path, weights_only = True))
model.eval()

# Vorhersage machen
with torch.no_grad():
    output = model(image)
    _, predicted = torch.max(output, 1)

# Ergebnis anzeigen
predicted_class = class_names[predicted.item()]
print(f'Predicted class: {predicted_class}')
