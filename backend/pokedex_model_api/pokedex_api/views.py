from django.shortcuts import render
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
import torch
from torchvision import transforms
from PIL import Image
import io
from .model import Model
import os

# Pfad zum gespeicherten Modell
model_path = os.path.join(os.path.dirname(__file__), 'pokedex_model.pth')

# Liste der Klassennamen
class_names = ['blastoise', 'butterfree', 'charizard', 'dragonite', 'gengar', 'gyarados', 'pikachu', 'rhyhorn', 'slowbro', 'venusaur']

# Transformationspipeline für das Bild
transform = transforms.Compose([
    transforms.Resize((64, 64)),
    transforms.ToTensor(),
    transforms.Normalize(mean=[0.485, 0.456, 0.406], std=[0.229, 0.224, 0.225])
])

# Modell laden
model = Model()
model.load_state_dict(torch.load(model_path, weights_only = True))
model.eval()

@csrf_exempt
def pokemon_classification(request):
    if request.method == 'POST':
        if 'file' not in request.FILES:
            return JsonResponse({'error': 'No file provided'}, status=400)

        file = request.FILES['file']
        if file.name == '':
            return JsonResponse({'error': 'No file selected'}, status=400)

        try:
            image = Image.open(file)
            image = transform(image).unsqueeze(0)  

            # Vorhersage machen
            with torch.no_grad():
                output = model(image)
                _, predicted = torch.max(output, 1)

            predicted_class = class_names[predicted.item()]
            return JsonResponse({'predicted_class': predicted_class})

        except Exception as e:
            return JsonResponse({'error': str(e)}, status=500)

    return JsonResponse({'error': 'Invalid request method'}, status=405)