view: vw_product_performance {
  sql_table_name: `modus-playground.sephora_demo.vw_product_performance` ;;

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

  dimension: subcategory {
    type: string
    sql: ${TABLE}.subcategory ;;
  }

  dimension: list_price {
    type: number
    sql: ${TABLE}.list_price ;;
    value_format_name: usd
    label: "List Price"
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

  # Revenue measures — summed so they roll up to brand/department level
  measure: total_purchases {
    type: sum
    sql: ${TABLE}.total_purchases ;;
    label: "Total Purchases"
  }

  measure: units_sold {
    type: sum
    sql: ${TABLE}.units_sold ;;
    label: "Units Sold"
  }

  measure: gross_revenue {
    type: sum
    sql: ${TABLE}.gross_revenue ;;
    value_format_name: usd_0
    label: "Gross Revenue"
    drill_fields: [product_name, brand_name, department, gross_revenue]
  }

  measure: effective_revenue {
    type: sum
    sql: ${TABLE}.effective_revenue ;;
    value_format_name: usd_0
    label: "Effective Revenue (adj. for returns)"
  }

  measure: revenue_lost_to_returns {
    type: number
    sql: SAFE_DIVIDE(
           SUM(${TABLE}.gross_revenue) - SUM(${TABLE}.effective_revenue),
           NULLIF(SUM(${TABLE}.gross_revenue), 0)
         ) ;;
    value_format_name: percent_1
    label: "Revenue Lost to Returns"
  }

  # Quality rate measures — averaged across products
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

  measure: avg_skin_match_rate {
    type: average
    sql: ${TABLE}.skin_match_rate ;;
    value_format_name: percent_1
    label: "Avg Skin Match Rate"
  }

  # Channel mix measures
  measure: avg_pct_online {
    type: average
    sql: ${TABLE}.pct_online ;;
    value_format_name: percent_1
    label: "% Online"
  }

  measure: avg_pct_in_store {
    type: average
    sql: ${TABLE}.pct_in_store ;;
    value_format_name: percent_1
    label: "% In-Store"
  }

  measure: avg_pct_app {
    type: average
    sql: ${TABLE}.pct_app ;;
    value_format_name: percent_1
    label: "% App"
  }

  measure: product_count {
    type: count_distinct
    sql: ${TABLE}.product_id ;;
    label: "Products Selling"
  }
}
