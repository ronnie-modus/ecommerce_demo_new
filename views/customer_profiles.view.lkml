view: customer_profiles {
  sql_table_name: `modus-playground.sephora_demo.customer_profiles` ;;

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
  }

  dimension: preferred_brands {
    type: string
    sql: ${TABLE}.preferred_brands ;;
    label: "Preferred Brands"
  }

  dimension: acquisition_source {
    type: string
    sql: ${TABLE}.acquisition_source ;;
    label: "Acquisition Source"
  }

  dimension_group: signup {
    type: time
    timeframes: [date, week, month, quarter, year]
    sql: SAFE_CAST(${TABLE}.signup_date AS DATE) ;;
    datatype: date
    convert_tz: no
    label: "Signup"
  }

  dimension: lifetime_spend {
    type: number
    sql: ${TABLE}.lifetime_spend ;;
    value_format_name: usd
    label: "Lifetime Spend"
  }

  dimension: avg_order_value {
    type: number
    sql: ${TABLE}.avg_order_value ;;
    value_format_name: usd
    label: "Avg Order Value"
  }

  dimension: email_opt_in {
    type: yesno
    sql: COALESCE(SAFE_CAST(${TABLE}.email_opt_in AS BOOL), FALSE) ;;
    label: "Email Opt-In"
  }

  dimension: push_opt_in {
    type: yesno
    sql: COALESCE(SAFE_CAST(${TABLE}.push_opt_in AS BOOL), FALSE) ;;
    label: "Push Opt-In"
  }

  measure: count {
    type: count
    label: "Customer Count"
    drill_fields: [customer_id, beauty_insider_tier, skin_type, age_group, acquisition_source]
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

  measure: avg_aov {
    type: average
    sql: ${TABLE}.avg_order_value ;;
    value_format_name: usd
    label: "Avg Order Value"
  }
}
