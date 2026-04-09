view: promotions {
  sql_table_name: `modus-playground.sephora_demo.promotions` ;;

  dimension: promo_id {
    type: string
    sql: ${TABLE}.promo_id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: promo_code {
    type: string
    sql: ${TABLE}.promo_code ;;
    label: "Promo Code"
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
    label: "Promotion Type"
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
    label: "Description"
  }

  dimension: eligible_tier {
    type: string
    sql: ${TABLE}.eligible_tier ;;
    label: "Eligible Tier"
  }

  dimension: eligible_department {
    type: string
    sql: ${TABLE}.eligible_department ;;
    label: "Eligible Department"
  }

  dimension: discount_value {
    type: number
    sql: ${TABLE}.discount_value ;;
    value_format_name: decimal_0
    label: "Discount Value"
  }

  dimension: min_order_value {
    type: number
    sql: ${TABLE}.min_order_value ;;
    value_format_name: usd
    label: "Min Order Value"
  }

  dimension_group: valid_from {
    type: time
    timeframes: [date, month, year]
    sql: SAFE_CAST(${TABLE}.valid_from AS DATE) ;;
    datatype: date
    convert_tz: no
    label: "Valid From"
  }

  dimension_group: valid_to {
    type: time
    timeframes: [date, month, year]
    sql: SAFE_CAST(${TABLE}.valid_to AS DATE) ;;
    datatype: date
    convert_tz: no
    label: "Valid To"
  }

  dimension: is_active {
    type: yesno
    sql: CURRENT_DATE() BETWEEN SAFE_CAST(${TABLE}.valid_from AS DATE)
                             AND SAFE_CAST(${TABLE}.valid_to AS DATE) ;;
    label: "Currently Active"
  }

  measure: count {
    type: count
    label: "Promotion Count"
    drill_fields: [promo_code, type, eligible_tier, discount_value]
  }

  measure: total_uses {
    type: sum
    sql: ${TABLE}.uses_count ;;
    label: "Total Uses"
  }

  measure: avg_discount {
    type: average
    sql: ${TABLE}.discount_value ;;
    value_format_name: decimal_1
    label: "Avg Discount Value"
  }
}
