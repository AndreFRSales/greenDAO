package de.greenrobot.daotest;

// THIS CODE IS GENERATED BY greenDAO, DO NOT EDIT. Enable "keep" sections if you want to edit. 
/**
 * Entity mapped to table DATE_ENTITY.
 */
public class DateEntity {

    private Long id;
    private java.util.Date date;
    /** Not-null value. */
    private java.util.Date dateNotNull;

    public DateEntity() {
    }

    public DateEntity(Long id) {
        this.id = id;
    }

    public DateEntity(Long id, java.util.Date date, java.util.Date dateNotNull) {
        this.id = id;
        this.date = date;
        this.dateNotNull = dateNotNull;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public java.util.Date getDate() {
        return date;
    }

    public void setDate(java.util.Date date) {
        this.date = date;
    }

    /** Not-null value. */
    public java.util.Date getDateNotNull() {
        return dateNotNull;
    }

    /** Not-null value; ensure this value is available before it is saved to the database. */
    public void setDateNotNull(java.util.Date dateNotNull) {
        this.dateNotNull = dateNotNull;
    }

}
