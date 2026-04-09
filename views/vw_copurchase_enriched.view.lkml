view: vw_copurchase_enriched {
  sql_table_name: `modus-playground.sephora_demo.vw_copurchase_enriched` ;;

  dimension: pk {
    type: string
    sql: CONCAT(${TABLE}.product_id_a, '|', ${TABLE}.product_id_b) ;;
    primary_key: yes
    hidden: yes
  }

  dimension: product_id_a {
    type: string
    sql: ${TABLE}.product_id_a ;;
    hidden: yes
  }

  dimension: product_id_b {
    type: string
    sql: ${TABLE}.product_id_b ;;
    hidden: yes
  }

  dimension: product_a_name {
    type: string
    sql: ${TABLE}.product_a_name ;;
    label: "Product A"
  }

  dimension: product_a_brand {
    type: string
    sql: ${TABLE}.product_a_brand ;;
    label: "Product A Brand"
  }

  dimension: product_a_department {
    type: string
    sql: ${TABLE}.product_a_department ;;
    label: "Product A Department"
  }

  dimension: product_b_name {
    type: string
    sql: ${TABLE}.product_b_name ;;
    label: "Also Bought"
  }

  dimension: product_b_brand {
    type: string
    sql: ${TABLE}.product_b_brand ;;
    label: "Also Bought Brand"
  }

  dimension: product_b_department {
    type: string
    sql: ${TABLE}.product_b_department ;;
    label: "Also Bought Department"
  }

  dimension: affinity_score {
    type: number
    sql: ${TABLE}.affinity_score ;;
    value_format_name: percent_1
    label: "Affinity Score"
  }

  measure: copurchase_count {
    type: sum
    sql: ${TABLE}.copurchase_count ;;
    label: "Co-purchase Count"
  }

  measure: avg_affinity_score {
    type: average
    sql: ${TABLE}.affinity_score ;;
    value_format_name: percent_1
    label: "Avg Affinity Score"
  }

  measure: avg_pct_of_a_buyers {
    type: average
    sql: ${TABLE}.pct_of_a_buyers ;;
    value_format_name: percent_1
    label: "% of Product A Buyers Who Also Bought B"
  }
}
