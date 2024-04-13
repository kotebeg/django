django-admin startproject labProjcets
cd labProjcets
python3 manage.py startapp app26

mkdir app26/templates/
mkdir app26/templates/app26
touch app26/templates/app26/app26.html

echo '
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Document</title>
    </head>
    <body>
        <h1>Header One</h1>
        <h2>Header Two</h2>
        <p>{{ month_name|title }}</p>
        <p>{{ text|title }}</p>m
    </body>
</html>
' >> app26/templates/app26/app26.html

touch app26/templates/app26/index.html

echo '
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>All Challanges</title>
    </head>
    <body>
        <ul>
            {% for month in month_list %} 
                <li><a href="{{ month|title }}"></li>
            {% endfor %}
        </ul>
    </body>
</html>
' >> app26/templates/app26/index.html




touch app26/urls.py
echo "from django.urls import path" >> app26/urls.py
echo "from . import views" >> app26/urls.py
echo "
urlpatterns = [
    path('', views.index, name = 'index'),
    path('<int:month>', views.get_month_by_id),
    path('<str:month>', views.get_month_by_name, name = 'month-challange'),
] 
" >> app26/urls.py

echo "
from django.http import HttpResponse, HttpResponseNotFound, HttpResponseRedirect
from django.urls import reverse
from django.template.loader import render_to_string
" >> app26/views.py

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
    'december':'from december from december from december',
}" >> app26/views.py

echo "
def index(request):
    list_items = ''
    month_list = list(monthly_challange.keys())
    print(month_list)
    return render(request, 'app26/index.html', {
        'month_list': month_list
    })

def get_month_by_id(request, month):
        month_list = list(monthly_challange.keys())
        if 1 <= month <=12:
            choosen_month = month_list[month]
            redirect_path = reverse('month-challange', args = [choosen_month] )
            return HttpResponseRedirect(redirect_path)
        else:
            error_path = reverse('error-path')
            return HttpResponseRedirect(error_path)
            " >> app26/views.py
echo "
def get_month_by_name(request, month):
        try:
            challenge_text = monthly_challange[month]
            return render(request, 'app26/app26.html', {
                'text': challenge_text,
                'month_name': month,
            })
            # resonse_data = render_to_string('app26/app26.html')  << we cen dot here also, 
            # return HttpResponse(resonse_data)
        except:
            return HttpResponseNotFound('This month is not supported!')
" >> app26/views.py

python3 manage.py startapp app27
touch app27/urls.py
echo "from django.urls import path" >> app27/urls.py
echo "from . import views" >> app27/urls.py


echo "
urlpatterns = [
    path('', views.index, name = 'error-path'),
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

sed -i "39a\    'app26'," labProjcets/labProjcets/settings.py
sed -i "40a\    'app27'," labProjcets/labProjcets/settings.py

python3 labProjcets/manage.py runserver


