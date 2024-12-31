import os
from PIL import Image
from torch.utils.data import Dataset, DataLoader

class PokemonDataset(Dataset):
    def __init__(self, root_dir, transform=None):
        self.root_dir = root_dir
        self.transform = transform
        self.classes = sorted(os.listdir(root_dir))
        self.images = []
        self.labels = []
        
        for label, class_name in enumerate(self.classes):
            class_dir = os.path.join(root_dir, class_name)
            if os.path.isdir(class_dir):
                for file in os.listdir(class_dir):
                    if file.endswith(('.png', '.jpg', '.jpeg', '.bmp', '.gif')):
                        self.images.append(os.path.join(class_dir, file))
                        self.labels.append(label)
    
    def __len__(self):
        return len(self.images)
    
    def __getitem__(self, idx):
        img_path = self.images[idx]
        image = Image.open(img_path)
        
        if image.mode == 'P' or (image.mode == 'RGBA' and 'transparency' in image.info):
            image = image.convert('RGBA')
        
        image = image.convert('RGB')
        
        label = self.labels[idx]
        
        if self.transform:
            image = self.transform(image)
        
        return image, label