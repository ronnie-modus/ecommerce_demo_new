view: categories {
  sql_table_name: `modus-playground.sephora_demo.categories` ;;

  dimension: category_id {
    type: string
    sql: ${TABLE}.category_id ;;
    primary_key: yes
    hidden: yes
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

  dimension: level {
    type: string
    sql: ${TABLE}.level ;;
    label: "Taxonomy Level"
  }

  dimension: parent_id {
    type: string
    sql: ${TABLE}.parent_id ;;
    hidden: yes
  }

  measure: count {
    type: count
    label: "Category Count"
    drill_fields: [department, section, subcategory]
  }
}
