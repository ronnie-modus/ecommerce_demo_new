view: vw_search_funnel {
  sql_table_name: `modus-playground.sephora_demo.vw_search_funnel` ;;

  dimension: session_id {
    type: string
    sql: ${TABLE}.session_id ;;
    primary_key: yes
    hidden: yes
  }

  dimension_group: session {
    type: time
    timeframes: [date, week, month, quarter, year]
    sql: ${TABLE}.session_date ;;
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

  dimension: converted {
    type: yesno
    sql: ${TABLE}.converted ;;
    label: "Session Converted"
  }

  dimension: added_to_cart {
    type: yesno
    sql: ${TABLE}.added_to_cart ;;
    label: "Added to Cart"
  }

  dimension: cart_abandoned {
    type: yesno
    sql: ${TABLE}.cart_abandoned ;;
    label: "Cart Abandoned"
  }

  dimension: beauty_insider_tier {
    type: string
    sql: ${TABLE}.beauty_insider_tier ;;
    label: "Beauty Insider Tier"
  }

  dimension: skin_type {
    type: string
    sql: ${TABLE}.skin_type ;;
    label: "Customer Skin Type"
  }

  dimension: duration_seconds {
    type: number
    sql: ${TABLE}.duration_seconds ;;
    hidden: yes
  }

  dimension: page_views {
    type: number
    sql: ${TABLE}.page_views ;;
    hidden: yes
  }

  measure: session_count {
    type: count
    label: "Sessions"
  }

  measure: converted_sessions {
    type: count
    filters: [converted: "Yes"]
    label: "Converted Sessions"
  }

  measure: conversion_rate {
    type: number
    sql: SAFE_DIVIDE(${converted_sessions}, NULLIF(${session_count}, 0)) ;;
    value_format_name: percent_1
    label: "Conversion Rate"
  }

  measure: cart_add_sessions {
    type: count
    filters: [added_to_cart: "Yes"]
    label: "Sessions with Cart Add"
  }

  measure: cart_add_rate {
    type: number
    sql: SAFE_DIVIDE(${cart_add_sessions}, NULLIF(${session_count}, 0)) ;;
    value_format_name: percent_1
    label: "Cart Add Rate"
  }

  measure: cart_abandon_sessions {
    type: count
    filters: [cart_abandoned: "Yes"]
    label: "Cart Abandoned Sessions"
  }

  measure: cart_abandon_rate {
    type: number
    sql: SAFE_DIVIDE(${cart_abandon_sessions}, NULLIF(${cart_add_sessions}, 0)) ;;
    value_format_name: percent_1
    label: "Cart Abandonment Rate"
  }

  measure: avg_page_views {
    type: average
    sql: ${TABLE}.page_views ;;
    value_format_name: decimal_1
    label: "Avg Page Views"
  }

  measure: avg_duration_min {
    type: number
    sql: SAFE_DIVIDE(AVG(${TABLE}.duration_seconds), 60) ;;
    value_format_name: decimal_1
    label: "Avg Session Duration (min)"
  }
}
