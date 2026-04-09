view: vw_segment_ratings {
  sql_table_name: `modus-playground.sephora_demo.vw_segment_ratings` ;;

  dimension: pk {
    type: string
    sql: CONCAT(${TABLE}.product_id, '|', COALESCE(${TABLE}.reviewer_skin_type,'x'),
               '|', COALESCE(${TABLE}.reviewer_skin_tone,'x'),
               '|', COALESCE(${TABLE}.reviewer_age_group,'x')) ;;
    primary_key: yes
    hidden: yes
  }

  dimension: product_id {
    type: string
    sql: ${TABLE}.product_id ;;
    hidden: yes
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}.product_name ;;
    label: "Product Name"
  }

  dimension: brand_name {
    type: string
    sql: ${TABLE}.brand_name ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: subcategory {
    type: string
    sql: ${TABLE}.subcategory ;;
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

  dimension: includes_matched_skin_type {
    type: yesno
    sql: ${TABLE}.includes_matched_skin_type ;;
    label: "Includes Matched Skin Type Reviews"
  }

  measure: total_reviews {
    type: sum
    sql: ${TABLE}.review_count ;;
    label: "Total Reviews"
  }

  measure: avg_rating {
    type: average
    sql: ${TABLE}.avg_rating ;;
    value_format_name: decimal_2
    label: "Avg Rating (segment)"
    drill_fields: [product_name, brand_name, reviewer_skin_type, reviewer_skin_tone, avg_rating]
  }

  measure: avg_recommendation_rate {
    type: average
    sql: ${TABLE}.recommendation_rate ;;
    value_format_name: percent_1
    label: "Avg Recommendation Rate"
  }

  measure: avg_helpfulness {
    type: average
    sql: ${TABLE}.avg_helpfulness ;;
    value_format_name: decimal_1
    label: "Avg Helpfulness Score"
  }
}
