view: browse_search_logs {
  sql_table_name: `modus-playground.sephora_demo.browse_search_logs` ;;

  dimension: session_id {
    type: string
    sql: ${TABLE}.session_id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: customer_id {
    type: string
    sql: ${TABLE}.customer_id ;;
    hidden: yes
  }

  dimension_group: session {
    type: time
    timeframes: [date, week, month, quarter, year]
    sql: SAFE_CAST(${TABLE}.session_date AS DATE) ;;
    datatype: date
    convert_tz: no
    label: "Session"
  }

  dimension: device_type {
    type: string
    sql: ${TABLE}.device_type ;;
    label: "Device Type"
  }

  dimension: acquisition_channel {
    type: string
    sql: ${TABLE}.acquisition_channel ;;
    label: "Acquisition Channel"
  }

  dimension: search_queries {
    type: string
    sql: ${TABLE}.search_queries ;;
    label: "Search Query"
  }

  dimension: query_intent {
    type: string
    sql: ${TABLE}.query_intent ;;
    label: "Query Intent"
  }

  dimension: products_viewed {
    type: string
    sql: ${TABLE}.products_viewed ;;
    label: "Products Viewed"
    hidden: yes
  }

  dimension: products_added_to_cart {
    type: string
    sql: ${TABLE}.products_added_to_cart ;;
    label: "Products Added to Cart"
    hidden: yes
  }

  dimension: converted_order_id {
    type: string
    sql: ${TABLE}.converted_order_id ;;
    hidden: yes
  }

  dimension: duration_seconds {
    type: number
    sql: ${TABLE}.duration_seconds ;;
    label: "Duration (seconds)"
  }

  dimension: page_views {
    type: number
    sql: ${TABLE}.page_views ;;
    label: "Page Views"
  }

  dimension: converted {
    type: yesno
    sql: ${TABLE}.converted_order_id IS NOT NULL ;;
    label: "Session Converted"
  }

  dimension: added_to_cart {
    type: yesno
    sql: ${TABLE}.products_added_to_cart IS NOT NULL
         AND ${TABLE}.products_added_to_cart != '' ;;
    label: "Added to Cart"
  }

  measure: session_count {
    type: count
    label: "Session Count"
  }

  measure: conversion_rate {
    type: number
    sql: SAFE_DIVIDE(
           COUNTIF(${TABLE}.converted_order_id IS NOT NULL),
           NULLIF(COUNT(${TABLE}.session_id), 0)
         ) ;;
    value_format_name: percent_1
    label: "Conversion Rate"
  }

  measure: cart_add_rate {
    type: number
    sql: SAFE_DIVIDE(
           COUNTIF(${TABLE}.products_added_to_cart IS NOT NULL
                   AND ${TABLE}.products_added_to_cart != ''),
           NULLIF(COUNT(${TABLE}.session_id), 0)
         ) ;;
    value_format_name: percent_1
    label: "Cart Add Rate"
  }

  measure: avg_page_views {
    type: average
    sql: ${TABLE}.page_views ;;
    value_format_name: decimal_1
    label: "Avg Page Views"
  }
}
