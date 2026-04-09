view: vw_schema_impact {
  sql_table_name: `modus-playground.sephora_demo.vw_schema_impact` ;;

  dimension: lineage_id {
    type: string
    sql: ${TABLE}.lineage_id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: source_table {
    type: string
    sql: ${TABLE}.source_table ;;
    label: "Source Table / Model"
  }

  dimension: source_column {
    type: string
    sql: ${TABLE}.source_column ;;
    label: "Source Column"
  }

  dimension: target_table {
    type: string
    sql: ${TABLE}.target_table ;;
    label: "Target Table / Model / Dashboard"
  }

  dimension: target_column {
    type: string
    sql: ${TABLE}.target_column ;;
    label: "Target Column"
  }

  dimension: transformation {
    type: string
    sql: ${TABLE}.transformation ;;
    label: "Transformation Type"
  }

  dimension: source_schema {
    type: string
    sql: ${TABLE}.source_schema ;;
    label: "Source Schema"
  }

  dimension: source_owner {
    type: string
    sql: ${TABLE}.source_owner ;;
    label: "Source Owner"
  }

  dimension: target_schema {
    type: string
    sql: ${TABLE}.target_schema ;;
    label: "Target Schema"
  }

  dimension: target_owner {
    type: string
    sql: COALESCE(${TABLE}.target_owner, ${TABLE}.target_dashboard_owner) ;;
    label: "Target Owner"
  }

  dimension: target_dashboard_name {
    type: string
    sql: ${TABLE}.target_dashboard_name ;;
    label: "Target Dashboard"
  }

  dimension: target_dashboard_tool {
    type: string
    sql: ${TABLE}.target_dashboard_tool ;;
    label: "Dashboard Tool"
  }

  dimension: refresh_frequency {
    type: string
    sql: ${TABLE}.refresh_frequency ;;
    label: "Refresh Frequency"
  }

  dimension: impact_severity {
    type: string
    sql: ${TABLE}.impact_severity ;;
    label: "Impact Severity"
  }

  dimension: impact_severity_rank {
    type: number
    sql: CASE ${TABLE}.impact_severity
           WHEN 'Critical' THEN 1
           WHEN 'High'     THEN 2
           WHEN 'Medium'   THEN 3
           ELSE 4
         END ;;
    hidden: yes
  }

  dimension: impact_severity_html {
    type: string
    sql: ${TABLE}.impact_severity ;;
    label: "Severity (coloured)"
    order_by_field: impact_severity_rank
    html:
      {% if value == 'Critical' %}
        <span style="background:#ef4444;color:white;padding:2px 8px;border-radius:4px">{{ value }}</span>
      {% elsif value == 'High' %}
        <span style="background:#f59e0b;color:white;padding:2px 8px;border-radius:4px">{{ value }}</span>
      {% elsif value == 'Medium' %}
        <span style="background:#3b82f6;color:white;padding:2px 8px;border-radius:4px">{{ value }}</span>
      {% else %}
        <span style="background:#6b7280;color:white;padding:2px 8px;border-radius:4px">{{ value }}</span>
      {% endif %} ;;
  }

  measure: lineage_edge_count {
    type: count
    label: "Lineage Edges"
  }

  measure: analyst_queries_on_source {
    type: sum
    sql: ${TABLE}.analyst_queries_on_source ;;
    label: "Analyst Queries on Source"
  }

  measure: affected_objects {
    type: count_distinct
    sql: ${TABLE}.target_table ;;
    label: "Affected Objects"
  }

  measure: critical_objects {
    type: count_distinct
    sql: CASE WHEN ${TABLE}.impact_severity = 'Critical' THEN ${TABLE}.target_table END ;;
    label: "Critical Objects"
  }
}
