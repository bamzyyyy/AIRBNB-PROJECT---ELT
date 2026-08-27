{% macro select_positive_values(model, column_name) %}
    Select *
    From {{model}}
    where {{column_name}} > 0
{% endmacro %}