django-admin startproject labProjcets
cd labProjcets
python3 manage.py startapp app26
touch app26/urls.py
echo "from django.urls import path" >> app26/urls.py
echo "from . import views" >> app26/urls.py
echo "
urlpatterns = [
    path('<int:month>', views.get_month_by_id),
    path('<str:month>', views.get_month_by_name),
] 
" >> app26/urls.py

echo "from django.http import HttpResponse, HttpResponseNotFound, HttpResponseRedirect" >> app26/views.py
echo "
monthly_challange = {
    'january':'from january',
    'february':'from february',
    'march':'from march',
    'april':'from april',
    'may':'from may',
    'june':'from june',
    'july':'from july',
    'august': 'from august',
    'september':'from september',
    'octomber':'from octomber',
    'november':'from november',
    'december':'from december'
}" >> app26/views.py

echo "
def get_month_by_id(request, month):
        month_list = list(monthly_challange.keys())
        if 1 <= month <=12:
            return HttpResponseRedirect('/app26/' + month_list[month-1])
        else:
            return HttpResponseRedirect('/app27/')
            " >> app26/views.py
echo "
def get_month_by_name(request, month):
        try:
            challenge_text = monthly_challange[month]
            return HttpResponse(challenge_text)
        except:
            return HttpResponseNotFound('This month is not supported!')" >> app26/views.py

python3 manage.py startapp app27
touch app27/urls.py
echo "from django.urls import path" >> app27/urls.py
echo "from . import views" >> app27/urls.py

echo "
urlpatterns = [
    path('', views.index),
] 
" >> app27/urls.py


echo "from django.http import HttpResponse" >> app27/views.py


echo "
def index(request):
    return HttpResponse('redirected to app27')
            " >> app27/views.py

cd ..
sed -i "18s/$/, include/" labProjcets/labProjcets/urls.py
sed -i "21a\    path('app26/', include('app26.urls'))," labProjcets/labProjcets/urls.py
sed -i "22a\    path('app27/', include('app27.urls'))," labProjcets/labProjcets/urls.py

python3 labProjcets/manage.py runserver
