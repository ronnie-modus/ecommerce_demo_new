view: brands {
  sql_table_name: `modus-playground.sephora_demo.brands` ;;

  dimension: brand_id {
    type: string
    sql: ${TABLE}.brand_id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: brand_name {
    type: string
    sql: ${TABLE}.brand_name ;;
    label: "Brand"
  }

  dimension: tier {
    type: string
    sql: ${TABLE}.tier ;;
    label: "Brand Tier"
  }

  dimension: primary_category {
    type: string
    sql: ${TABLE}.primary_category ;;
    label: "Primary Category"
  }

  dimension: secondary_category {
    type: string
    sql: ${TABLE}.secondary_category ;;
    label: "Secondary Category"
  }

  dimension: is_clean_certified {
    type: yesno
    sql: COALESCE(SAFE_CAST(${TABLE}.is_clean_certified AS BOOL), FALSE) ;;
    label: "Clean at Sephora Certified"
  }

  dimension: typical_price_lo {
    type: number
    sql: ${TABLE}.typical_price_lo ;;
    value_format_name: usd
    label: "Typical Price (Low)"
  }

  dimension: typical_price_hi {
    type: number
    sql: ${TABLE}.typical_price_hi ;;
    value_format_name: usd
    label: "Typical Price (High)"
  }

  measure: count {
    type: count
    label: "Brand Count"
    drill_fields: [brand_name, tier, primary_category]
  }
}
