view: dashboard_metadata {
  sql_table_name: `modus-playground.sephora_demo.dashboard_metadata` ;;

  dimension: dashboard_id {
    type: string
    sql: ${TABLE}.dashboard_id ;;
    primary_key: yes
    label: "Dashboard ID"
    hidden: yes
  }

  dimension: dashboard_name {
    type: string
    sql: ${TABLE}.dashboard_name ;;
    label: "Dashboard Name"
  }

  dimension: display_name {
    type: string
    sql: ${TABLE}.display_name ;;
    label: "Display Name"
  }

  dimension: tool {
    type: string
    sql: ${TABLE}.tool ;;
    label: "BI Tool"
  }

  dimension: source_models {
    type: string
    sql: ${TABLE}.source_models ;;
    label: "Source Models"
    description: "Pipe-separated dbt model names"
  }

  dimension: columns_referenced {
    type: string
    sql: ${TABLE}.columns_referenced ;;
    label: "Columns Referenced"
  }

  dimension: owner_team {
    type: string
    sql: ${TABLE}.owner_team ;;
    label: "Owner Team"
  }

  dimension: refresh_frequency {
    type: string
    sql: ${TABLE}.refresh_frequency ;;
    label: "Refresh Frequency"
  }

  dimension_group: last_updated {
    type: time
    timeframes: [date, month, year]
    sql: SAFE_CAST(${TABLE}.last_updated AS DATE) ;;
    datatype: date
    convert_tz: no
    label: "Last Updated"
  }

  measure: dashboard_count {
    type: count
    label: "Dashboard Count"
    drill_fields: [display_name, tool, owner_team, refresh_frequency]
  }
}
