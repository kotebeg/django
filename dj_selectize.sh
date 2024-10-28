
#!/bin/bash
var_project_name="dj_project_selectize"
var_app_name="app_selectize"


django-admin startproject "$var_project_name"

# change directory to: dj_project_selectize
cd "$var_project_name"

python3 manage.py startapp "$var_app_name"


touch "$var_app_name"/urls.py
echo "from django.urls import path" >> "$var_app_name"/urls.py
echo "from . import views"          >> "$var_app_name"/urls.py


mkdir "$var_app_name"/static
mkdir "$var_app_name"/static/"$var_app_name"
mkdir "$var_app_name"/static/"$var_app_name"/css
mkdir "$var_app_name"/static/"$var_app_name"/js

mkdir "$var_app_name"/templates
mkdir "$var_app_name"/templates/includes
mkdir "$var_app_name"/templates/"$var_app_name"


# create html files
touch "$var_app_name"/templates/"$var_app_name"/index.html
touch "$var_app_name"/templates/"$var_app_name"/layout.html


# routing
echo "
urlpatterns = [
    path('<int:month>', views.get_month_by_id),
    path('<str:month>', views.get_month_by_name),
] 
"       >>"$var_app_name"/urls.py


#  views.py
echo "from django.http import HttpResponse, HttpResponseNotFound, HttpResponseRedirect" >> "$var_app_name"/views.py
echo "" >> "$var_app_name"/views.py

echo "
def def_one(request):
        pass
">> "$var_app_name"/views.py

echo "
def def_two(request):
        pass
" >> "$var_app_name"/views.py

cd ..

# creat readme file ------------
touch "$var_project_name"/readme.md
echo  "# django selectize" >> "$var_project_name"/readme.md
# # creat readme file ------------

sed -i "18s/$/, include/" "$var_project_name"/"$var_project_name"/urls.py
sed -i "21a\    path('"$var_project_name"/', include('"$var_project_name".urls'))," "$var_project_name"/"$var_project_name"/urls.py

# python3 "$var_project_name"/manage.py runserver


