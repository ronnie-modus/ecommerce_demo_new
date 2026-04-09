view: product_attributes {
  sql_table_name: `modus-playground.sephora_demo.product_attributes` ;;

  dimension: product_id {
    type: string
    sql: ${TABLE}.product_id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: skin_type_fit {
    type: string
    sql: ${TABLE}.skin_type_fit ;;
    label: "Skin Type Fit"
    description: "Pipe-separated: oily|dry|combination|normal|sensitive"
  }

  dimension: skin_concern {
    type: string
    sql: ${TABLE}.skin_concern ;;
    label: "Skin Concern"
    description: "Pipe-separated: aging|acne|dark spots|redness|pores|dullness"
  }

  dimension: finish_type {
    type: string
    sql: ${TABLE}.finish_type ;;
    label: "Finish Type"
  }

  dimension: coverage_level {
    type: string
    sql: ${TABLE}.coverage_level ;;
    label: "Coverage Level"
  }

  dimension: key_ingredients {
    type: string
    sql: ${TABLE}.key_ingredients ;;
    label: "Key Ingredients"
  }

  dimension: fragrance_family {
    type: string
    sql: ${TABLE}.fragrance_family ;;
    label: "Fragrance Family"
  }

  dimension: clean_flag {
    type: yesno
    sql: COALESCE(SAFE_CAST(${TABLE}.clean_flag AS BOOL), FALSE) ;;
    label: "Clean at Sephora"
  }

  dimension: vegan_flag {
    type: yesno
    sql: COALESCE(SAFE_CAST(${TABLE}.vegan_flag AS BOOL), FALSE) ;;
    label: "Vegan"
  }

  dimension: cruelty_free_flag {
    type: yesno
    sql: COALESCE(SAFE_CAST(${TABLE}.cruelty_free_flag AS BOOL), FALSE) ;;
    label: "Cruelty-Free"
  }

  dimension: shade_range_size {
    type: number
    sql: ${TABLE}.shade_range_size ;;
    label: "Shade Range Size"
  }

  measure: count {
    type: count
    label: "Attribute Record Count"
  }

  measure: avg_shade_range {
    type: average
    sql: ${TABLE}.shade_range_size ;;
    value_format_name: decimal_0
    label: "Avg Shade Range"
  }

  measure: pct_clean {
    type: number
    sql: SAFE_DIVIDE(COUNTIF(SAFE_CAST(${TABLE}.clean_flag AS BOOL) = TRUE), COUNT(*)) ;;
    value_format_name: percent_1
    label: "% Clean Certified"
  }

  measure: pct_vegan {
    type: number
    sql: SAFE_DIVIDE(COUNTIF(SAFE_CAST(${TABLE}.vegan_flag AS BOOL) = TRUE), COUNT(*)) ;;
    value_format_name: percent_1
    label: "% Vegan"
  }
}
