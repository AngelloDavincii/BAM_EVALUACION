
from django.urls import path


from data.views import *

urlpatterns = [

    path('', inicio.as_view(), name="inicio"),
    
]
