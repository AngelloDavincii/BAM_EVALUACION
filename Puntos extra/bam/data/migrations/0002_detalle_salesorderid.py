# Generated by Django 3.1 on 2021-05-24 04:14

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('data', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='detalle',
            name='SalesOrderID',
            field=models.IntegerField(null=True),
        ),
    ]
