view: products {
  sql_table_name: `modus-playground.sephora_demo.products` ;;

  dimension: product_id {
    type: string
    sql: ${TABLE}.product_id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: brand_name {
    type: string
    sql: ${TABLE}.brand_name ;;
    label: "Brand"
  }

  dimension: brand_id {
    type: string
    sql: ${TABLE}.brand_id ;;
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

  dimension: category_id {
    type: string
    sql: ${TABLE}.category_id ;;
    hidden: yes
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
    label: "SKU"
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

  dimension: rating {
    type: number
    sql: ${TABLE}.rating ;;
    value_format_name: decimal_1
    label: "Overall Rating"
  }

  dimension: reviews_count {
    type: number
    sql: ${TABLE}.reviews_count ;;
    label: "Review Count"
  }

  dimension: loves_count {
    type: number
    sql: ${TABLE}.loves_count ;;
    label: "Loves Count"
  }

  dimension: size_label {
    type: string
    sql: ${TABLE}.size_label ;;
    label: "Size"
  }

  dimension: is_anchor {
    type: yesno
    sql: COALESCE(SAFE_CAST(${TABLE}.is_anchor AS BOOL), FALSE) ;;
    label: "Demo Anchor Product"
    hidden: yes
  }

  measure: count {
    type: count
    label: "Product Count"
    drill_fields: [product_name, brand_name, department, price, rating]
  }

  measure: avg_price {
    type: average
    sql: ${TABLE}.price ;;
    value_format_name: usd
    label: "Avg Price"
  }

  measure: avg_rating {
    type: average
    sql: ${TABLE}.rating ;;
    value_format_name: decimal_2
    label: "Avg Rating"
  }

  measure: total_loves {
    type: sum
    sql: ${TABLE}.loves_count ;;
    label: "Total Loves"
  }
}
