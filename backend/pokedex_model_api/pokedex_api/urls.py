from django.urls import path
from . import views

urlpatterns = [
    path('classification', views.pokemon_classification, name='classification'),
]