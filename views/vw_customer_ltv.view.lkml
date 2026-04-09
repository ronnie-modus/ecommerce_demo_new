view: vw_customer_ltv {
  sql_table_name: `modus-playground.sephora_demo.vw_customer_ltv` ;;

  dimension: customer_id {
    type: string
    sql: ${TABLE}.customer_id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: beauty_insider_tier {
    type: string
    sql: ${TABLE}.beauty_insider_tier ;;
    label: "Beauty Insider Tier"
  }

  dimension: skin_type {
    type: string
    sql: ${TABLE}.skin_type ;;
    label: "Skin Type"
  }

  dimension: skin_tone {
    type: string
    sql: ${TABLE}.skin_tone ;;
    label: "Skin Tone"
  }

  dimension: age_group {
    type: string
    sql: ${TABLE}.age_group ;;
    label: "Age Group"
  }

  dimension: top_concerns {
    type: string
    sql: ${TABLE}.top_concerns ;;
    label: "Top Concerns"
    description: "Pipe-separated beauty concerns"
  }

  dimension: acquisition_source {
    type: string
    sql: ${TABLE}.acquisition_source ;;
    label: "Acquisition Source"
  }

  dimension_group: signup {
    type: time
    timeframes: [date, week, month, quarter, year]
    sql: ${TABLE}.signup_date ;;
    datatype: date
    convert_tz: no
    label: "Signup"
  }

  dimension: eligible_promo_codes {
    type: string
    sql: ${TABLE}.eligible_promo_codes ;;
    label: "Eligible Promo Codes"
  }

  dimension: days_since_last_purchase {
    type: number
    sql: ${TABLE}.days_since_last_purchase ;;
    label: "Days Since Last Purchase"
  }

  dimension: churn_risk {
    type: string
    sql: CASE
           WHEN ${TABLE}.days_since_last_purchase > 180 THEN 'High'
           WHEN ${TABLE}.days_since_last_purchase > 90  THEN 'Medium'
           ELSE 'Low'
         END ;;
    label: "Churn Risk"
  }

  measure: customer_count {
    type: count
    label: "Customer Count"
    drill_fields: [customer_id, beauty_insider_tier, skin_type, age_group]
  }

  measure: avg_lifetime_spend {
    type: average
    sql: ${TABLE}.lifetime_spend ;;
    value_format_name: usd_0
    label: "Avg Lifetime Spend"
  }

  measure: total_lifetime_spend {
    type: sum
    sql: ${TABLE}.lifetime_spend ;;
    value_format_name: usd_0
    label: "Total Lifetime Spend"
  }

  measure: avg_order_value {
    type: average
    sql: ${TABLE}.avg_order_value ;;
    value_format_name: usd
    label: "Avg Order Value"
  }

  measure: avg_total_orders {
    type: average
    sql: ${TABLE}.total_orders ;;
    value_format_name: decimal_1
    label: "Avg Orders per Customer"
  }

  measure: avg_return_rate {
    type: average
    sql: ${TABLE}.return_rate ;;
    value_format_name: percent_1
    label: "Avg Return Rate"
  }

  measure: avg_repurchase_rate {
    type: average
    sql: ${TABLE}.repurchase_rate ;;
    value_format_name: percent_1
    label: "Avg Repurchase Rate"
  }

  measure: avg_recommendation_rate {
    type: average
    sql: ${TABLE}.recommendation_rate ;;
    value_format_name: percent_1
    label: "Avg AI Recommendation Rate"
  }

  measure: pct_at_churn_risk {
    type: number
    sql: SAFE_DIVIDE(
           COUNTIF(${TABLE}.days_since_last_purchase > 90),
           NULLIF(COUNT(${TABLE}.customer_id), 0)
         ) ;;
    value_format_name: percent_1
    label: "% at Churn Risk (90+ days)"
  }
}
