$(function(){
   $('#vencimiento').datetimepicker({
       format:"YYYY-MM-DD",
       date: moment().format("YYYY-MM-DD"),
       locale: 'es',
       minDate: moment().format("YYYY-MM-DD"),
       }
   );

   
   $('#s').datetimepicker({
    format:"YYYY-MM-DD",
    date: moment().format("YYYY-MM-DD"),
    locale: 'es',
    minDate: moment().format("YYYY-MM-DD"),
    
  });

   $('.select2').select2({
       theme: "bootstrap4",
       language: 'es'
    });
});
