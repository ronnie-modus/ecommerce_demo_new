connection: "sephora_demo"

include: "/views/*.view.lkml"
include: "/dashboards/*.dashboard.lookml"

datagroup: daily_refresh {
  sql_trigger: SELECT MAX(purchase_date) FROM `modus-playground.sephora_demo.purchase_history` ;;
  max_cache_age: "24 hours"
}

explore: vw_product_full {
  label: "Products & Attributes"
  description: "Product catalog enriched with attributes, ratings, performance, and co-purchase data."
  persist_with: daily_refresh

  join: vw_segment_ratings {
    type: left_outer
    sql_on: ${vw_product_full.product_id} = ${vw_segment_ratings.product_id} ;;
    relationship: one_to_many
    view_label: "Ratings by Segment"
  }

  join: vw_product_performance {
    type: left_outer
    sql_on: ${vw_product_full.product_id} = ${vw_product_performance.product_id} ;;
    relationship: one_to_one
    view_label: "Commercial Performance"
  }

  join: vw_copurchase_enriched {
    type: left_outer
    sql_on: ${vw_product_full.product_id} = ${vw_copurchase_enriched.product_id_a} ;;
    relationship: one_to_many
    view_label: "Co-purchase Pairs"
  }
}

explore: vw_customer_ltv {
  label: "Customers & LTV"
  description: "Customer profiles enriched with lifetime purchase metrics and eligible promotions."
  persist_with: daily_refresh
}

explore: vw_search_funnel {
  label: "Search & Browse Funnel"
  description: "Session-level search behaviour with pre-computed conversion and cart abandonment flags."
  persist_with: daily_refresh
}

explore: vw_segment_ratings {
  label: "Reviews by Segment"
  description: "Pre-aggregated ratings by product x skin type x skin tone x age group."
  persist_with: daily_refresh

  join: vw_product_full {
    type: left_outer
    sql_on: ${vw_segment_ratings.product_id} = ${vw_product_full.product_id} ;;
    relationship: many_to_one
    view_label: "Product Details"
  }
}

explore: vw_product_performance {
  label: "Merchandising Performance"
  description: "Brand and product revenue, return rates, repurchase rates, and channel mix."
  persist_with: daily_refresh

  join: vw_product_full {
    type: left_outer
    sql_on: ${vw_product_performance.product_id} = ${vw_product_full.product_id} ;;
    relationship: many_to_one
    view_label: "Product Attributes"
  }
}

explore: vw_inclusivity_scorecard {
  label: "Inclusivity Scorecard"
  description: "Shade range coverage vs satisfaction rating by skin tone per brand."
  persist_with: daily_refresh
}

explore: vw_schema_impact {
  label: "Schema and Lineage"
  description: "Column lineage from raw tables through dbt models to dashboards, with analyst query usage."
  persist_with: daily_refresh
}
