view: purchase_history {
  sql_table_name: `modus-playground.sephora_demo.purchase_history` ;;

  dimension: order_id {
    type: string
    sql: ${TABLE}.order_id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: customer_id {
    type: string
    sql: ${TABLE}.customer_id ;;
    hidden: yes
  }

  dimension: product_id {
    type: string
    sql: ${TABLE}.product_id ;;
    hidden: yes
  }

  dimension_group: purchase {
    type: time
    timeframes: [date, week, month, quarter, year]
    sql: SAFE_CAST(${TABLE}.purchase_date AS DATE) ;;
    datatype: date
    convert_tz: no
    label: "Purchase"
  }

  dimension: quantity {
    type: number
    sql: ${TABLE}.quantity ;;
  }

  dimension: unit_price {
    type: number
    sql: ${TABLE}.unit_price ;;
    value_format_name: usd
    label: "Unit Price"
  }

  dimension: channel {
    type: string
    sql: ${TABLE}.channel ;;
    label: "Purchase Channel"
  }

  dimension: was_recommended {
    type: yesno
    sql: COALESCE(SAFE_CAST(${TABLE}.was_recommended AS BOOL), FALSE) ;;
    label: "AI Recommended"
  }

  dimension: is_reorder {
    type: yesno
    sql: COALESCE(SAFE_CAST(${TABLE}.is_reorder AS BOOL), FALSE) ;;
    label: "Is Reorder"
  }

  dimension: returned {
    type: yesno
    sql: COALESCE(SAFE_CAST(${TABLE}.returned AS BOOL), FALSE) ;;
    label: "Returned"
  }

  dimension: skin_match {
    type: yesno
    sql: COALESCE(SAFE_CAST(${TABLE}.skin_match AS BOOL), FALSE) ;;
    label: "Skin Type Match"
  }

  measure: order_count {
    type: count
    label: "Order Count"
    drill_fields: [order_id, purchase_date, channel, unit_price]
  }

  measure: gross_revenue {
    type: sum
    sql: ${TABLE}.quantity * ${TABLE}.unit_price ;;
    value_format_name: usd_0
    label: "Gross Revenue"
  }

  measure: units_sold {
    type: sum
    sql: ${TABLE}.quantity ;;
    label: "Units Sold"
  }

  measure: return_rate {
    type: number
    sql: SAFE_DIVIDE(
           COUNTIF(SAFE_CAST(${TABLE}.returned AS BOOL) = TRUE),
           NULLIF(COUNT(${TABLE}.order_id), 0)
         ) ;;
    value_format_name: percent_1
    label: "Return Rate"
  }

  measure: repurchase_rate {
    type: number
    sql: SAFE_DIVIDE(
           COUNTIF(SAFE_CAST(${TABLE}.is_reorder AS BOOL) = TRUE),
           NULLIF(COUNT(${TABLE}.order_id), 0)
         ) ;;
    value_format_name: percent_1
    label: "Repurchase Rate"
  }

  measure: recommendation_rate {
    type: number
    sql: SAFE_DIVIDE(
           COUNTIF(SAFE_CAST(${TABLE}.was_recommended AS BOOL) = TRUE),
           NULLIF(COUNT(${TABLE}.order_id), 0)
         ) ;;
    value_format_name: percent_1
    label: "AI Recommendation Rate"
  }

  measure: skin_match_rate {
    type: number
    sql: SAFE_DIVIDE(
           COUNTIF(SAFE_CAST(${TABLE}.skin_match AS BOOL) = TRUE),
           NULLIF(COUNT(${TABLE}.order_id), 0)
         ) ;;
    value_format_name: percent_1
    label: "Skin Match Rate"
  }

  measure: avg_unit_price {
    type: average
    sql: ${TABLE}.unit_price ;;
    value_format_name: usd
    label: "Avg Unit Price"
  }
}
