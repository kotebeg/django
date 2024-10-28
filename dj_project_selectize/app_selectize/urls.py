from django.urls import path
from . import views

urlpatterns = [
    path('<int:month>', views.get_month_by_id),
    path('<str:month>', views.get_month_by_name),
] 

