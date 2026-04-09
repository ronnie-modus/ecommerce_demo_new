view: vw_product_full {
  sql_table_name: `modus-playground.sephora_demo.vw_product_full` ;;

  dimension: product_id {
    type: string
    sql: ${TABLE}.product_id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}.product_name ;;
    label: "Product Name"
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: section {
    type: string
    sql: ${TABLE}.section ;;
  }

  dimension: subcategory {
    type: string
    sql: ${TABLE}.subcategory ;;
  }

  dimension: price {
    type: number
    sql: ${TABLE}.price ;;
    value_format_name: usd
  }

  dimension: price_tier {
    type: tier
    tiers: [15, 30, 50, 100, 200]
    style: integer
    sql: ${TABLE}.price ;;
    label: "Price Range"
  }

  dimension: overall_rating {
    type: number
    sql: ${TABLE}.overall_rating ;;
    value_format_name: decimal_1
  }

  dimension: reviews_count {
    type: number
    sql: ${TABLE}.reviews_count ;;
  }

  dimension: loves_count {
    type: number
    sql: ${TABLE}.loves_count ;;
  }

  dimension: is_anchor {
    type: yesno
    sql: ${TABLE}.is_anchor ;;
    label: "Demo Anchor Product"
    hidden: yes
  }

  dimension: brand_name {
    type: string
    sql: ${TABLE}.brand_name ;;
  }

  dimension: brand_tier {
    type: string
    sql: ${TABLE}.brand_tier ;;
    label: "Brand Tier"
  }

  dimension: brand_is_clean {
    type: yesno
    sql: COALESCE(SAFE_CAST(${TABLE}.brand_is_clean AS BOOL), FALSE) ;;
    label: "Brand Clean Certified"
  }

  dimension: skin_type_fit {
    type: string
    sql: ${TABLE}.skin_type_fit ;;
    label: "Skin Type Fit"
    description: "Pipe-separated: oily|dry|combination|normal|sensitive"
  }

  dimension: fits_dry_skin {
    type: yesno
    sql: ${TABLE}.skin_type_fit LIKE '%dry%' ;;
    label: "Fits Dry Skin"
  }

  dimension: fits_oily_skin {
    type: yesno
    sql: ${TABLE}.skin_type_fit LIKE '%oily%' ;;
    label: "Fits Oily Skin"
  }

  dimension: fits_sensitive_skin {
    type: yesno
    sql: ${TABLE}.skin_type_fit LIKE '%sensitive%' ;;
    label: "Fits Sensitive Skin"
  }

  dimension: skin_concern {
    type: string
    sql: ${TABLE}.skin_concern ;;
    label: "Skin Concern"
    description: "Pipe-separated: aging|acne|dark spots|redness|pores|dullness"
  }

  dimension: addresses_aging {
    type: yesno
    sql: ${TABLE}.skin_concern LIKE '%aging%' ;;
    label: "Addresses Aging"
  }

  dimension: addresses_acne {
    type: yesno
    sql: ${TABLE}.skin_concern LIKE '%acne%' ;;
    label: "Addresses Acne"
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
    description: "Pipe-separated active ingredients"
  }

  dimension: has_retinol {
    type: yesno
    sql: ${TABLE}.key_ingredients LIKE '%retinol%' ;;
    label: "Contains Retinol"
  }

  dimension: has_hyaluronic_acid {
    type: yesno
    sql: ${TABLE}.key_ingredients LIKE '%hyaluronic acid%' ;;
    label: "Contains Hyaluronic Acid"
  }

  dimension: has_niacinamide {
    type: yesno
    sql: ${TABLE}.key_ingredients LIKE '%niacinamide%' ;;
    label: "Contains Niacinamide"
  }

  dimension: has_vitamin_c {
    type: yesno
    sql: ${TABLE}.key_ingredients LIKE '%vitamin C%' ;;
    label: "Contains Vitamin C"
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

  dimension: shade_range_tier {
    type: tier
    tiers: [1, 10, 20, 40]
    style: integer
    sql: ${TABLE}.shade_range_size ;;
    label: "Shade Range (bucketed)"
  }

  measure: count {
    type: count
    label: "Product Count"
    drill_fields: [product_name, brand_name, department, price, overall_rating]
  }

  measure: avg_price {
    type: average
    sql: ${TABLE}.price ;;
    value_format_name: usd
    label: "Avg Price"
  }

  measure: avg_rating {
    type: average
    sql: ${TABLE}.overall_rating ;;
    value_format_name: decimal_2
    label: "Avg Overall Rating"
  }

  measure: avg_shade_range {
    type: average
    sql: ${TABLE}.shade_range_size ;;
    value_format_name: decimal_0
    label: "Avg Shade Range"
  }

  measure: total_loves {
    type: sum
    sql: ${TABLE}.loves_count ;;
    label: "Total Loves"
  }
}
