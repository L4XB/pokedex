import torch
import torch.nn as nn
import torch.nn.functional as F

class Model(nn.Module):
    def __init__(self):
        super(Model, self).__init__()
        
        # Convolutional layers with Batch Normalization and Dropout
        self.conv1 = nn.Conv2d(in_channels=3, out_channels=32, kernel_size=3, padding=1)
        self.bn1 = nn.BatchNorm2d(32)
        self.dropout1 = nn.Dropout(0.3)
        
        self.conv2 = nn.Conv2d(in_channels=32, out_channels=64, kernel_size=3, padding=1)
        self.bn2 = nn.BatchNorm2d(64)
        self.dropout2 = nn.Dropout(0.3)
        
        self.conv3 = nn.Conv2d(in_channels=64, out_channels=128, kernel_size=3, padding=1)
        self.bn3 = nn.BatchNorm2d(128)
        self.dropout3 = nn.Dropout(0.4)
        
        self.conv4 = nn.Conv2d(in_channels=128, out_channels=256, kernel_size=3, padding=1)
        self.bn4 = nn.BatchNorm2d(256)
        self.dropout4 = nn.Dropout(0.4)
        
        self.conv5 = nn.Conv2d(in_channels=256, out_channels=512, kernel_size=3, padding=1)
        self.bn5 = nn.BatchNorm2d(512)
        self.dropout5 = nn.Dropout(0.5)
        
        # Max pooling layer
        self.pool = nn.MaxPool2d(kernel_size=2, stride=2, padding=0)
        
        # Adaptive pooling layer
        self.adaptive_pool = nn.AdaptiveAvgPool2d((2, 2))
        
        # Fully connected layers with Dropout
        self.fc1 = nn.Linear(512 * 2 * 2, 512)
        self.dropout_fc1 = nn.Dropout(0.5)
        self.fc2 = nn.Linear(512, 10) 

    def forward(self, x):
        x = self.pool(F.relu(self.bn1(self.conv1(x))))
        x = self.dropout1(x)
        
        x = self.pool(F.relu(self.bn2(self.conv2(x))))
        x = self.dropout2(x)
        
        x = self.pool(F.relu(self.bn3(self.conv3(x))))
        x = self.dropout3(x)
        
        x = self.pool(F.relu(self.bn4(self.conv4(x))))
        x = self.dropout4(x)
        
        x = self.pool(F.relu(self.bn5(self.conv5(x))))
        x = self.dropout5(x)
        
        x = self.adaptive_pool(x)
        x = x.view(-1, 512 * 2 * 2)
        
        x = F.relu(self.fc1(x))
        x = self.dropout_fc1(x)
        x = self.fc2(x)
        
        return x