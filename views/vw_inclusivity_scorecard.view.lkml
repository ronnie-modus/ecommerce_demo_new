view: vw_inclusivity_scorecard {
  sql_table_name: `modus-playground.sephora_demo.vw_inclusivity_scorecard` ;;

  dimension: pk {
    type: string
    sql: CONCAT(${TABLE}.brand_name, '|', ${TABLE}.department, '|',
               COALESCE(${TABLE}.reviewer_skin_tone,'x')) ;;
    primary_key: yes
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

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: reviewer_skin_tone {
    type: string
    sql: ${TABLE}.reviewer_skin_tone ;;
    label: "Skin Tone"
  }

  dimension: avg_shade_range {
    type: number
    sql: ${TABLE}.avg_shade_range ;;
    label: "Avg Shade Range Size"
  }

  dimension: rating_gap_across_tones {
    type: number
    sql: ${TABLE}.rating_gap_across_tones ;;
    value_format_name: decimal_2
    label: "Rating Gap (max − min tone)"
  }

  dimension: inclusivity_classification {
    type: string
    sql: ${TABLE}.inclusivity_classification ;;
    label: "Inclusivity Classification"
  }

  dimension: inclusivity_classification_html {
    type: string
    sql: ${TABLE}.inclusivity_classification ;;
    label: "Classification (coloured)"
    html:
      {% if value == 'Inclusive' %}
        <span style="background:#22c55e;color:white;padding:2px 8px;border-radius:4px">{{ value }}</span>
      {% elsif value == 'Coverage gap' %}
        <span style="background:#f59e0b;color:white;padding:2px 8px;border-radius:4px">{{ value }}</span>
      {% elsif value == 'Performance gap' %}
        <span style="background:#ef4444;color:white;padding:2px 8px;border-radius:4px">{{ value }}</span>
      {% else %}
        <span style="background:#7c3aed;color:white;padding:2px 8px;border-radius:4px">{{ value }}</span>
      {% endif %} ;;
  }

  measure: review_count {
    type: sum
    sql: ${TABLE}.review_count ;;
    label: "Review Count"
  }

  measure: avg_rating {
    type: average
    sql: ${TABLE}.avg_rating ;;
    value_format_name: decimal_2
    label: "Avg Rating"
  }

  measure: avg_recommendation_rate {
    type: average
    sql: ${TABLE}.recommendation_rate ;;
    value_format_name: percent_1
    label: "Avg Recommendation Rate"
  }

  measure: avg_rating_gap {
    type: average
    sql: ${TABLE}.rating_gap_across_tones ;;
    value_format_name: decimal_2
    label: "Avg Rating Gap Across Tones"
  }

  measure: brand_count {
    type: count_distinct
    sql: ${TABLE}.brand_name ;;
    label: "Brands"
  }
}
