package ir.piana.dev.strutser.data.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Table(name = "users")
@SequenceGenerator(name = "users_seq", initialValue = 1, sequenceName = "users_seq", allocationSize = 1)
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class GoogleUserEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "users_seq")
    @Column(name = "id")
    private long Id;
    @Column(name = "user_id")
    private String userId;
    @Column(name = "email")
    private String username;
    @Column
    private String password;
    @Column(name = "email_verified")
    private boolean emailVerified;
    @Column
    private String name;
    @Column(name = "picture_url")
    private String pictureUrl;
    @Column
    private String locale;
    @Column(name = "family_name")
    private String familyName;
    @Column(name = "given_name")
    private String givenName;

    public GoogleUserEntity(String userId, String email, String password, boolean emailVerified, String name, String pictureUrl, String locale, String familyName, String givenName) {
        this.userId = userId;
        this.username = email;
        this.password = password;
        this.emailVerified = emailVerified;
        this.name = name;
        this.pictureUrl = pictureUrl;
        this.locale = locale;
        this.familyName = familyName;
        this.givenName = givenName;
    }

//    public GoogleUserEntity() {
//
//    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean isEmailVerified() {
        return emailVerified;
    }

    public void setEmailVerified(boolean emailVerified) {
        this.emailVerified = emailVerified;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPictureUrl() {
        return pictureUrl;
    }

    public void setPictureUrl(String pictureUrl) {
        this.pictureUrl = pictureUrl;
    }

    public String getLocale() {
        return locale;
    }

    public void setLocale(String locale) {
        this.locale = locale;
    }

    public String getFamilyName() {
        return familyName;
    }

    public void setFamilyName(String familyName) {
        this.familyName = familyName;
    }

    public String getGivenName() {
        return givenName;
    }

    public void setGivenName(String givenName) {
        this.givenName = givenName;
    }

    public long getId() {
        return Id;
    }

    public void setId(long id) {
        Id = id;
    }
}
