view: product_copurchase {
  sql_table_name: `modus-playground.sephora_demo.product_copurchase` ;;

  dimension: pk {
    type: string
    sql: CONCAT(${TABLE}.product_id_a, '|', ${TABLE}.product_id_b) ;;
    primary_key: yes
    hidden: yes
  }

  dimension: product_id_a {
    type: string
    sql: ${TABLE}.product_id_a ;;
    label: "Product A ID"
    hidden: yes
  }

  dimension: product_id_b {
    type: string
    sql: ${TABLE}.product_id_b ;;
    label: "Also Bought Product ID"
    hidden: yes
  }

  dimension: pct_of_a_buyers {
    type: number
    sql: ${TABLE}.pct_of_a_buyers ;;
    value_format_name: percent_1
    label: "% of A Buyers Also Buying B"
  }

  dimension: pct_of_b_buyers {
    type: number
    sql: ${TABLE}.pct_of_b_buyers ;;
    value_format_name: percent_1
    label: "% of B Buyers Also Buying A"
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

  measure: avg_affinity {
    type: average
    sql: ${TABLE}.affinity_score ;;
    value_format_name: percent_1
    label: "Avg Affinity Score"
  }

  measure: pair_count {
    type: count
    label: "Co-purchase Pairs"
  }
}
