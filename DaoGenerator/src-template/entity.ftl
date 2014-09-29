<#--

Copyright (C) 2011 Markus Junginger, greenrobot (http://greenrobot.de)     
                                                                           
This file is part of greenDAO Generator.                                   
                                                                           
greenDAO Generator is free software: you can redistribute it and/or modify 
it under the terms of the GNU General Public License as published by       
the Free Software Foundation, either version 3 of the License, or          
(at your option) any later version.                                        
greenDAO Generator is distributed in the hope that it will be useful,      
but WITHOUT ANY WARRANTY; without even the implied warranty of             
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the              
GNU General Public License for more details.                               
                                                                           
You should have received a copy of the GNU General Public License          
along with greenDAO Generator.  If not, see <http://www.gnu.org/licenses/>.

-->
<#assign toBindType = {"Boolean":"Long", "Byte":"Long", "Short":"Long", "Int":"Long", "Long":"Long", "Float":"Double", "Double":"Double", "String":"String", "ByteArray":"Blob" }/>
<#assign toCursorType = {"Boolean":"Short", "Byte":"Short", "Short":"Short", "Int":"Int", "Long":"Long", "Float":"Float", "Double":"Double", "String":"String", "ByteArray":"Blob" }/>
<#assign complexTypes = ["String", "ByteArray", "Date"]/>
<#assign boxedTypes = ["Boolean", "Byte", "Short", "Integer", "Long", "Float", "Double", "java.util.Date"]/>
package ${entity.javaPackage};

<#if entity.toManyRelations?has_content>
import java.util.List;
</#if>
<#if entity.active>
import ${schema.defaultJavaPackageDao}.DaoSession;
import de.greenrobot.dao.DaoException;

</#if>
<#if entity.parcelable>
import android.os.BadParcelableException;
import android.os.Parcel;
import android.os.Parcelable;
import com.docusign.dataaccess.DataProviderException;

</#if>
<#if entity.additionalImportsEntity?has_content>
<#list entity.additionalImportsEntity as additionalImport>
import ${additionalImport};
</#list>

</#if>
<#if entity.hasKeepSections>
// THIS CODE IS GENERATED BY greenDAO, EDIT ONLY INSIDE THE "KEEP"-SECTIONS

// KEEP INCLUDES - put your custom includes here
<#if keepIncludes?has_content>${keepIncludes!}</#if>// KEEP INCLUDES END
<#else>
// THIS CODE IS GENERATED BY greenDAO, DO NOT EDIT. Enable "keep" sections if you want to edit. 
</#if>
/**
 * Entity mapped to table ${entity.tableName}.
 */
public class ${entity.className}<#if
entity.superclass?has_content> extends ${entity.superclass} </#if><#if
entity.interfacesToImplement?has_content> implements <#list entity.interfacesToImplement
as ifc>${ifc}<#if ifc_has_next>, </#if></#list></#if> {

<#list entity.properties as property>
<#if property.notNull && complexTypes?seq_contains(property.propertyType)>
    /** Not-null value. */
</#if>
    private ${property.javaType} ${property.propertyName};
</#list>

<#if entity.active>
    /** Used to resolve relations */
    private transient DaoSession daoSession;

    /** Used for active entity operations. */
    private transient ${entity.classNameDao} myDao;

<#list entity.toOneRelations as toOne>
    private ${toOne.targetEntity.className} ${toOne.name};
<#if toOne.useFkProperty>
    private ${toOne.resolvedKeyJavaType[0]} ${toOne.name}__resolvedKey;
<#else>
    private boolean ${toOne.name}__refreshed;
</#if>

</#list>
<#list entity.toManyRelations as toMany>
    private List<${toMany.targetEntity.className}> ${toMany.name};
</#list>

</#if>
<#if entity.hasKeepSections>
    // KEEP FIELDS - put your custom fields here
${keepFields!}    // KEEP FIELDS END

</#if>
<#if entity.constructors>
    public ${entity.className}() {
    }
<#if entity.propertiesPk?has_content && entity.propertiesPk?size != entity.properties?size>

    public ${entity.className}(<#list entity.propertiesPk as
property>${property.javaType} ${property.propertyName}<#if property_has_next>, </#if></#list>) {
<#list entity.propertiesPk as property>
        this.${property.propertyName} = ${property.propertyName};
</#list>
    }
</#if>

    public ${entity.className}(<#list entity.properties as
property>${property.javaType} ${property.propertyName}<#if property_has_next>, </#if></#list>) {
<#list entity.properties as property>
        this.${property.propertyName} = ${property.propertyName};
</#list>
    }
</#if>

<#if entity.active>
    /** called by internal mechanisms, do not call yourself. */
    public void __setDaoSession(DaoSession daoSession) {
        this.daoSession = daoSession;
        myDao = daoSession != null ? daoSession.get${entity.classNameDao?cap_first}() : null;
    }

</#if>
<#list entity.properties as property>
<#if property.notNull && complexTypes?seq_contains(property.propertyType)>
    /** Not-null value. */
</#if>
    public ${property.javaType} get${property.propertyName?cap_first}() {
        return ${property.propertyName};
    }

<#if property.notNull && complexTypes?seq_contains(property.propertyType)>
    /** Not-null value; ensure this value is available before it is saved to the database. */
</#if>
    public void set${property.propertyName?cap_first}(${property.javaType} ${property.propertyName}) {
        this.${property.propertyName} = ${property.propertyName};
    }

</#list>
<#--
##########################################
########## To-One Relations ##############
##########################################
-->
<#list entity.toOneRelations as toOne>
    /** To-one relationship, resolved on first access. */
    public ${toOne.targetEntity.className} get${toOne.name?cap_first}() {
<#if toOne.useFkProperty>    
        if (${toOne.name}__resolvedKey == null || <#--
        --><#if toOne.resolvedKeyUseEquals[0]>!${toOne.name}__resolvedKey.equals(${toOne.fkProperties[0].propertyName})<#--
        --><#else>${toOne.name}__resolvedKey != ${toOne.fkProperties[0].propertyName}</#if>) {
            if (daoSession == null) {
                throw new DaoException("Entity is detached from DAO context");
            }
            ${toOne.targetEntity.classNameDao} targetDao = daoSession.get${toOne.targetEntity.classNameDao?cap_first}();
            ${toOne.name} = targetDao.load(${toOne.fkProperties[0].propertyName});
            ${toOne.name}__resolvedKey = ${toOne.fkProperties[0].propertyName};
        }
<#else>
        if (${toOne.name} != null || !${toOne.name}__refreshed) {
            if (daoSession == null) {
                throw new DaoException("Entity is detached from DAO context");
            }
            ${toOne.targetEntity.classNameDao} targetDao = daoSession.get${toOne.targetEntity.classNameDao?cap_first}();
            targetDao.refresh(${toOne.name});
            ${toOne.name}__refreshed = true;
        }
</#if>
        return ${toOne.name};
    }
<#if !toOne.useFkProperty>

    /** To-one relationship, returned entity is not refreshed and may carry only the PK property. */
    public ${toOne.targetEntity.className} peak${toOne.name?cap_first}() {
        return ${toOne.name};
    }
</#if>

    public void set${toOne.name?cap_first}(${toOne.targetEntity.className} ${toOne.name}) {
<#if toOne.fkProperties[0].notNull>
        if (${toOne.name} == null) {
            throw new DaoException("To-one property '${toOne.fkProperties[0].propertyName}' has not-null constraint; cannot set to-one to null");
        }
</#if>
        this.${toOne.name} = ${toOne.name};
<#if toOne.useFkProperty>        
        ${toOne.fkProperties[0].propertyName} = <#if !toOne.fkProperties[0].notNull>${toOne.name} == null ? null : </#if>${toOne.name}.get${toOne.targetEntity.pkProperty.propertyName?cap_first}();
        ${toOne.name}__resolvedKey = ${toOne.fkProperties[0].propertyName};
<#else>
        ${toOne.name}__refreshed = true;
</#if>
    }

</#list>
<#--
##########################################
########## To-Many Relations #############
##########################################
-->
<#list entity.toManyRelations as toMany>
    /** To-many relationship, resolved on first access (and after reset). Changes to to-many relations are not persisted, make changes to the target entity. */
    public synchronized List<${toMany.targetEntity.className}> get${toMany.name?cap_first}() {
        if (${toMany.name} == null) {
            if (daoSession == null) {
                throw new DaoException("Entity is detached from DAO context");
            }
            ${toMany.targetEntity.classNameDao} targetDao = daoSession.get${toMany.targetEntity.classNameDao?cap_first}();
            ${toMany.name} = targetDao._query${toMany.sourceEntity.className?cap_first}_${toMany.name?cap_first}(<#--
                --><#list toMany.sourceProperties as property>${property.propertyName}<#if property_has_next>, </#if></#list>);
        }
        return ${toMany.name};
    }

    /** Resets a to-many relationship, making the next get call to query for a fresh result. */
    public synchronized void reset${toMany.name?cap_first}() {
        ${toMany.name} = null;
    }

</#list>
<#--
##########################################
########## Active entity operations ######
##########################################
-->
<#if entity.active>
    /** Convenient call for {@link AbstractDao#delete(Object)}. Entity must attached to an entity context. */
    public void delete() {
        if (myDao == null) {
            throw new DaoException("Entity is detached from DAO context");
        }    
        myDao.delete(this);
    }

    /** Convenient call for {@link AbstractDao#update(Object)}. Entity must attached to an entity context. */
    public void update() {
        if (myDao == null) {
            throw new DaoException("Entity is detached from DAO context");
        }    
        myDao.update(this);
    }

    /** Convenient call for {@link AbstractDao#refresh(Object)}. Entity must attached to an entity context. */
    public void refresh() {
        if (myDao == null) {
            throw new DaoException("Entity is detached from DAO context");
        }    
        myDao.refresh(this);
    }

    /* package */ DaoSession getDaoSession() {
        return daoSession;
    }

</#if>
<#if entity.parcelable>
    public static final Parcelable.Creator<${entity.className}> CREATOR = new Parcelable.Creator<${entity.className}>() {
        @Override
        public ${entity.className} createFromParcel(Parcel source) {
            if (source.readByte() == 1) {
                try {
                    return DocuSignDB.get(source.readString()).getSession().get${entity.classNameDao?cap_first}().queryBuilder()
                            .where(<#list entity.propertiesPk as pk>${entity.classNameDao?cap_first}.Properties.${pk.propertyName?cap_first}.eq(<#switch pk.javaType>
                                    <#case "Boolean"><#case "boolean">source.readByte() == 1<#break/>
                                    <#case "java.util.Date">new Date(source.readLong())<#break/>
                                    <#case "Integer">source.readInt()<#break/>
                                    <#default>source.read${pk.javaType?cap_first}()</#switch>)<#if pk_has_next>,</#if></#list>)
                            .uniqueOrThrow();
                } catch (DataProviderException e) {
                    throw new BadParcelableException(e);
                }
            } else {
                ${entity.className} model = new ${entity.className}();
<#list entity.properties as property>
<#if !entity.propertiesPk?seq_contains(property)>
<#if boxedTypes?seq_contains(property.javaType)>
                if (source.readByte() == 1)
    </#if>                model.${property.propertyName} = <#rt/>
<#switch property.javaType>
<#case "Boolean"><#case "boolean">source.readByte() == 1<#break/>
<#case "java.util.Date">new java.util.Date(source.readLong())<#break/>
<#case "Integer">source.readInt()<#break/>
<#case "byte[]">source.createByteArray()<#break/>
<#default>source.read${property.javaType?cap_first}()</#switch>;
</#if>
</#list>
                return model;
            }
        }

        @Override
        public ${entity.className}[] newArray(int size) {
            return new ${entity.className}[size];
        }
    };

    @Override
    public int describeContents() {
        return 0;
    }

    @Override
    public void writeToParcel(Parcel dest, int flags) {
        if (myDao != null && myDao.getKey(this) != null
                && daoSession != null && DocuSignDB.getDBName(daoSession.getDatabase()) != null) {
            dest.writeByte((byte) 1);
            dest.writeString(DocuSignDB.getDBName(daoSession.getDatabase()));
<#list entity.propertiesPk as pk>
            dest.write<#switch pk.javaType>
<#case "Boolean"><#case "boolean">Byte((byte)(${pk.propertyName} ? 1 : 0))<#break/>
<#case "java.util.Date">Long(${pk.propertyName}.getTime())<#break/>
<#case "Integer">Int(${pk.propertyName})<#break/>
<#case "byte[]">ByteArray(${pk.propertyName})<#break/>
<#default>${pk.javaType?cap_first}(${pk.propertyName})</#switch>;
</#list>
        } else {
            dest.writeByte((byte) 0);
<#list entity.properties as property>
<#if !entity.propertiesPk?seq_contains(property)>
<#if boxedTypes?seq_contains(property.javaType)>
            dest.writeByte((byte)(${property.propertyName} == null ? 0 : 1));
            if (${property.propertyName} != null)
    </#if>            dest.write<#switch property.javaType>
<#case "Boolean"><#case "boolean">Byte((byte)(${property.propertyName} ? 1 : 0))<#break/>
<#case "java.util.Date">Long(${property.propertyName}.getTime())<#break/>
<#case "Integer">Int(${property.propertyName})<#break/>
<#case "byte[]">ByteArray(${property.propertyName})<#break/>
<#default>${property.javaType?cap_first}(${property.propertyName})</#switch>;
</#if>
</#list>
        }
    }

</#if>
<#if entity.hasKeepSections>
    // KEEP METHODS - put your custom methods here
${keepMethods!}    // KEEP METHODS END

</#if>
}
