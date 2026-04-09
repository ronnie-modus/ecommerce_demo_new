connection: "bigquery_sephora"

include: "/views/*.view.lkml"
include: "/dashboards/*.dashboard.lookml"

datagroup: daily_refresh {
  sql_trigger: SELECT MAX(purchase_date) FROM `modus-playground.sephora_demo.purchase_history` ;;
  max_cache_age: "24 hours"
}

# ── 1. Product discovery & comparison ───────────────────────────
explore: product_discovery {
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

# ── 2. Customer segments & LTV ───────────────────────────────────
explore: customer_analysis {
  from: vw_customer_ltv
  label: "Customers & LTV"
  description: "Customer profiles enriched with lifetime purchase metrics and eligible promotions."
  persist_with: daily_refresh
}

# ── 3. Search → purchase funnel ──────────────────────────────────
explore: search_funnel {
  from: vw_search_funnel
  label: "Search & Browse Funnel"
  description: "Session-level search behaviour with pre-computed conversion and cart abandonment flags."
  persist_with: daily_refresh
}

# ── 4. Review intelligence ───────────────────────────────────────
explore: review_intelligence {
  from: vw_segment_ratings
  label: "Reviews by Segment"
  description: "Pre-aggregated ratings by product × skin type × skin tone × age group."
  persist_with: daily_refresh

  join: vw_product_full {
    type: left_outer
    sql_on: ${review_intelligence.product_id} = ${vw_product_full.product_id} ;;
    relationship: many_to_one
    view_label: "Product Details"
  }
}

# ── 5. Merchandising performance ─────────────────────────────────
explore: merchandising {
  from: vw_product_performance
  label: "Merchandising Performance"
  description: "Brand and product revenue, return rates, repurchase rates, and channel mix."
  persist_with: daily_refresh

  join: vw_product_full {
    type: left_outer
    sql_on: ${merchandising.product_id} = ${vw_product_full.product_id} ;;
    relationship: many_to_one
    view_label: "Product Attributes"
  }
}

# ── 6. Inclusivity ───────────────────────────────────────────────
explore: inclusivity {
  from: vw_inclusivity_scorecard
  label: "Inclusivity Scorecard"
  description: "Shade range coverage vs satisfaction rating by skin tone per brand."
  persist_with: daily_refresh
}

# ── 7. Schema & lineage ──────────────────────────────────────────
explore: schema_impact {
  from: vw_schema_impact
  label: "Schema & Lineage"
  description: "Column lineage from raw tables through dbt models to dashboards, with analyst query usage."
  persist_with: daily_refresh
}
