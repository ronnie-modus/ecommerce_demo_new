view: product_reviews {
  sql_table_name: `modus-playground.sephora_demo.product_reviews` ;;

  dimension: review_id {
    type: string
    sql: ${TABLE}.review_id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: product_id {
    type: string
    sql: ${TABLE}.product_id ;;
    hidden: yes
  }

  dimension: customer_id {
    type: string
    sql: ${TABLE}.customer_id ;;
    hidden: yes
  }

  dimension: order_id {
    type: string
    sql: ${TABLE}.order_id ;;
    hidden: yes
  }

  dimension: rating {
    type: number
    sql: ${TABLE}.rating ;;
    label: "Rating"
  }

  dimension: review_text {
    type: string
    sql: ${TABLE}.review_text ;;
    label: "Review Text"
  }

  dimension: is_recommended {
    type: yesno
    sql: COALESCE(SAFE_CAST(${TABLE}.is_recommended AS BOOL), FALSE) ;;
    label: "Is Recommended"
  }

  dimension: helpfulness_score {
    type: number
    sql: ${TABLE}.helpfulness_score ;;
    label: "Helpfulness Score"
  }

  dimension: reviewer_skin_type {
    type: string
    sql: ${TABLE}.reviewer_skin_type ;;
    label: "Reviewer Skin Type"
  }

  dimension: reviewer_skin_tone {
    type: string
    sql: ${TABLE}.reviewer_skin_tone ;;
    label: "Reviewer Skin Tone"
  }

  dimension: reviewer_age_group {
    type: string
    sql: ${TABLE}.reviewer_age_group ;;
    label: "Reviewer Age Group"
  }

  dimension: verified_purchase {
    type: yesno
    sql: COALESCE(SAFE_CAST(${TABLE}.verified_purchase AS BOOL), FALSE) ;;
    label: "Verified Purchase"
  }

  dimension_group: created {
    type: time
    timeframes: [date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
    datatype: timestamp
    label: "Review Date"
  }

  measure: review_count {
    type: count
    label: "Review Count"
    drill_fields: [review_id, rating, reviewer_skin_type, reviewer_skin_tone, review_text]
  }

  measure: avg_rating {
    type: average
    sql: ${TABLE}.rating ;;
    value_format_name: decimal_2
    label: "Avg Rating"
  }

  measure: recommendation_rate {
    type: number
    sql: SAFE_DIVIDE(
           COUNTIF(SAFE_CAST(${TABLE}.is_recommended AS BOOL) = TRUE),
           NULLIF(COUNT(${TABLE}.review_id), 0)
         ) ;;
    value_format_name: percent_1
    label: "Recommendation Rate"
  }

  measure: avg_helpfulness {
    type: average
    sql: ${TABLE}.helpfulness_score ;;
    value_format_name: decimal_1
    label: "Avg Helpfulness Score"
  }
}
