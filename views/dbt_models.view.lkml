view: dbt_models {
  sql_table_name: `modus-playground.sephora_demo.dbt_models` ;;

  dimension: model_name {
    type: string
    sql: ${TABLE}.model_name ;;
    primary_key: yes
    label: "Model Name"
  }

  dimension: schema {
    type: string
    sql: ${TABLE}.schema ;;
    label: "Schema"
  }

  dimension: materialization {
    type: string
    sql: ${TABLE}.materialization ;;
    label: "Materialization"
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
    label: "Description"
  }

  dimension: sql_preview {
    type: string
    sql: ${TABLE}.sql_preview ;;
    label: "SQL Preview"
    hidden: yes
  }

  dimension: source_tables {
    type: string
    sql: ${TABLE}.source_tables ;;
    label: "Source Tables"
    description: "Pipe-separated source tables/models"
  }

  dimension: columns_used {
    type: string
    sql: ${TABLE}.columns_used ;;
    label: "Columns Used"
    description: "Pipe-separated columns"
  }

  dimension: downstream_models {
    type: string
    sql: ${TABLE}.downstream_models ;;
    label: "Downstream Models"
    description: "Pipe-separated downstream model names"
  }

  dimension: owner {
    type: string
    sql: ${TABLE}.owner ;;
    label: "Owner Team"
  }

  dimension_group: last_modified {
    type: time
    timeframes: [date, month, year]
    sql: SAFE_CAST(${TABLE}.last_modified AS DATE) ;;
    datatype: date
    convert_tz: no
    label: "Last Modified"
  }

  measure: model_count {
    type: count
    label: "Model Count"
    drill_fields: [model_name, schema, materialization, owner]
  }
}
