from django.shortcuts import render
from django.views.generic import TemplateView, ListView
from django.utils.decorators import method_decorator
from django.views.decorators.csrf import csrf_exempt
from data.models import *
import pandas as pd

def terr():
    datos = []
    datos2 = []
    todo = sales.objects.all()
    for i in todo:
        datos.append(i.toJSON())
    data = pd.DataFrame(datos)

    todo2 = territory.objects.all()
    for j in todo2:
        datos2.append(j.toJSON())
    data2 = pd.DataFrame(datos2)
    data2 = data2.rename(columns={"id":"territory"})
    # print(data.columns)
    # print("********")
    # print(data2.columns)
    merge = pd.merge(data, data2, on="territory")
    a = merge.groupby("group").sum()
    a = a["total"]/1000
    b = [{
            "name": 'Europe',
            "y": a[0],
        }, {
            "name": 'North America',
            "y": a[1]
        }, {
            "name": 'Pacific',
            "y": a[2]
        }]
    return b

def bestCustomer():
    datos = []
    todo = sales.objects.all()
    for i in todo:
        datos.append(i.toJSON())
    data = pd.DataFrame(datos)
    data["date"] = pd.to_datetime(data['date'])
    #print(data.info())
    data["month"] = pd.DatetimeIndex(data['date']).month
    a = data.groupby("month").sum()
    a = a["total"] / 1000
    a = round(a,2)
    a = list(a)
    b = []
    c = {}
    c["name"] = "Datos"
    c["data"] = a
    b.append(c)
    return b

class inicio(TemplateView):
    template_name = "dash.html"

    @method_decorator(csrf_exempt)
    def dispatch(self, request, *args, **kwargs):
        return super().dispatch(request, *args, **kwargs)

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context["resumen"] = bestCustomer()
        context["data"] = terr()
        return context
# Create your views here.
