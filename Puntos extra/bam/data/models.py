from django.db import models
from django.forms import model_to_dict

# Create your models here.


class product(models.Model):
    name = models.CharField(max_length=255, null=True)
    StandardCost = models.FloatField(null=True)
    daysToManufacture = models.IntegerField(null=True)
    
    def toJSON(self):
        item=model_to_dict(self)
        return item

class detalle(models.Model):
    SalesOrderID = models.IntegerField(null=True)
    OrderyQty = models.IntegerField(null=True)
    Product = models.ForeignKey(product, on_delete=models.SET_NULL, null=True)
    UnitPrice = models.FloatField(null=True)
    LineTotal = models.FloatField(null=True)

    def toJSON(self):
        item=model_to_dict(self)
        return item

class territory(models.Model):
    name = models.CharField(max_length=50, null=True)
    group = models.CharField(max_length=50, null=True)

    def toJSON(self):
        item=model_to_dict(self)
        return item

class seller(models.Model):
    name = models.CharField(max_length=50, null=True)

    def toJSON(self):
        item=model_to_dict(self)
        return item

class sales(models.Model):
    date = models.DateTimeField(null=True)
    customer = models.IntegerField(null=True)
    salesPerson = models.ForeignKey(seller, on_delete = models.SET_NULL,null=True)
    territory = models.ForeignKey(territory, on_delete = models.SET_NULL,null=True)
    total = models.FloatField(null=True)

    def toJSON(self):
        item=model_to_dict(self)
        item['date'] = self.date.strftime('%Y-%m-%d')
        return item
