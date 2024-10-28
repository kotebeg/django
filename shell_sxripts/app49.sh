django-admin startproject labProjcets
cd labProjcets

# templates
# base.html
mkdir templates
touch templates/base.html
echo '

{% load static %}

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>{% block page_title %}{% endblock %}</title>

        <link rel="stylesheet" href = {% static "base.css" %}>
        {% block css_files %}
        
        {% endblock  %}
    </head>
    <body>
        {% block content %}{% endblock %}
    </body>
</html>

' >>  templates/base.html

# 404.html
touch templates/404.html
echo '
{% extends "base.html" %}

{% block page_title %}
something went wrong, we cennto find page
{% endblock  %}

{% block  content %}
    <h1>we couldnot find page</h1>
    <p>from 404 html</p>
{% endblock  %}

' >>  templates/404.html

# static global
mkdir static
touch static/base.css


echo "
@import url('https://fonts.googleapis.com/css2?family=Roboto+Mono:ital,wght@0,100..700;1,100..700&display=swap');

html{
    font-family: Roboto Mono;
    font-optical-sizing: auto;
    /* font-weight: <weight>; */
    font-style: normal;
}

body {
    margin: 0;
    background-color:  #1a1a1a;
}


" >> static/base.css

python3 manage.py startapp app26

#app26.html
mkdir app26/templates/
mkdir app26/templates/app26
touch app26/templates/app26/app26.html

echo '
{% extends "base.html" %}
{% load static %}

{% block page_title %}Document{% endblock %}

{% block css_files %}
    <link rel="stylesheet" href = "{% static "app26/app26_month.css" %}">
    <link rel="stylesheet" href = "{% static "app26/includes/header.css" %}">
{% endblock  %}


{% block content %}
{% include "./inlcudes/header.html" with active_page="variable inside include for MONTH page"%}

        <h1>Header One</h1>
        <h2>Header Two</h2>
        <p>{{ month_name|title }}</p>
        {% if text is not None %}
            <p>{{ text|title }}</p>
        {% else %}
            <p>There is no data for this month</p>
        {% endif %}
        <br> <br> <br>
        <h2>from python funciton</h2>
        <p>{{ py_funct }}</p>
{% endblock %}

' >> app26/templates/app26/app26.html

# inlcudes
mkdir app26/templates/app26/inlcudes
touch app26/templates/app26/inlcudes/header.html

echo '

<header>
    <nav>
        <a href="{% url "index" %}">index</a>
    </nav>
    <p>{{ active_page }}</p>
</header>

' >> app26/templates/app26/inlcudes/header.html



# index.html
touch app26/templates/app26/index.html

echo '

{% extends "base.html" %}
{% load static %}

{% block css_files %}
        <link rel="stylesheet" href = "{% static "app26/app26.css" %}">
        <link rel="stylesheet" href = "{% static "app26/includes/header.css" %}">
{% endblock  %}

{% block page_title %}All Challanges{% endblock %}
{% block content %}
{% include "./inlcudes/header.html" with active_page="variable inside include for INDEX page"%}
    <ul>
        {% for month_iter in month_list %} 
            <li><a href="{% url "month-challange" month=month_iter %}">{{ month_iter|title }}</a></li>
        {% endfor %}
    </ul>
{% endblock %}

' >> app26/templates/app26/index.html

# static app26.css
mkdir app26/static/
mkdir app26/static/app26
touch app26/static/app26/app26.css

echo '
ul {
    list-style: none;
    margin: 2rem auto;
    width: 90%;
    max-width: 20rem;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.26);
    padding: 1rem;
    border-radius: 12px;
    display: flex;
    flex-direction: column;
    flex-wrap: wrap;
    height: 35rem;
    background-color: white;
}

li {
    margin: 1rem 0;
    text-align: center;
    font-size: 1.5rem;
    border-bottom: 1px solid #ccc;
    padding-bottom: 1rem;
}

li:last-of-type,
li:nth-of-type(6) {
    border-bottom: none;
}

li a {
    text-decoration: none;
    color: black;
}

li a:hover,
li a:active {
    color: purple
}

p {
    color: white;
}


' >>app26/static/app26/app26.css


mkdir app26/static/app26/includes
touch app26/static/app26/includes/header.css

echo '
header {
    width: 100%;
    height: 5rem;
    background-color: #8d8a8a;
}

header nav {
    width: 100%;
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
}

head nav a {
    color: white;
    font-size: 2rem;
    font-weight: bold;
    text-decoration: none;
}

header nav a:hover,
header nav a:active {
    color: #7e0154;
}
' >> app26/static/app26/includes/header.css

# app26_month.css

touch app26/static/app26/app26_month.css
echo '
h1, 
h2 {
    font-size: 1.5rem;
    font-family: normal;
    text-align: center;
    color: white;

}

h1 {
    font-size: 1.5rem;
    color:brown
}

h2 {
    font-size: 3rem;
}

p, h2 {
    color: white;
}

' >> app26/static/app26/app26_month.css



# urls
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

# views.py
echo "
from django.http import HttpResponse, HttpResponseNotFound, HttpResponseRedirect, Http404
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
    'november': None,
    'december':'from december from december from december',
}" >> app26/views.py

echo "
def index(request):
    list_items = ''
    month_list = list(monthly_challange.keys())
    # print(month_list)
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
def print_in_dtl():
    return 'print from function, throught DTL'


def get_month_by_name(request, month):
        try:
            challenge_text = monthly_challange[month]
            return render(request, 'app26/app26.html', {
                'text': challenge_text,
                'month_name': month,
                'py_funct': print_in_dtl()
            })
        except:
            raise Http404()

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


sed -i "59a\            BASE_DIR/'templates',]," labProjcets/labProjcets/settings.py

sed -i 59d labProjcets/labProjcets/settings.py
sed -i "58a\        'DIRS': [" labProjcets/labProjcets/settings.py

sed -i "123a\STATICFILES_DIRS = [" labProjcets/labProjcets/settings.py
sed -i "124a\  BASE_DIR / 'static'" labProjcets/labProjcets/settings.py
sed -i "125a\  ]" labProjcets/labProjcets/settings.py



python3 labProjcets/manage.py runserver

