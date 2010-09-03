<?xml version="1.0" encoding="utf-8"?>
<!--

    Licensed to Jasig under one or more contributor license
    agreements. See the NOTICE file distributed with this work
    for additional information regarding copyright ownership.
    Jasig licenses this file to you under the Apache License,
    Version 2.0 (the "License"); you may not use this file
    except in compliance with the License. You may obtain a
    copy of the License at:

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on
    an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied. See the License for the
    specific language governing permissions and limitations
    under the License.

-->

<!--
 | This file determines the presentation of the portal preferences interface.
 | The file is imported by the base stylesheet universality.xsl.
 | Parameters and templates from other XSL files may be referenced; refer to universality.xsl for the list of parameters and imported XSL files.
 | For more information on XSL, refer to [http://www.w3.org/Style/XSL/].
-->

<!-- ============================================= -->
<!-- ========== STYLESHEET DELCARATION =========== -->
<!-- ============================================= -->
<!-- 
 | RED
 | This statement defines this document as XSL and declares the Xalan extension
 | elements used for URL generation and permissions checks.
 |
 | If a change is made to this section it MUST be copied to all other XSL files
 | used by the theme
-->
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:xalan="http://xml.apache.org/xalan" 
  xmlns:dlm="http://www.uportal.org/layout/dlm"
  xmlns:portal="http://www.jasig.org/uportal/XSL/portal"
  xmlns:portlet="http://www.jasig.org/uportal/XSL/portlet"
  xmlns:layout="http://www.jasig.org/uportal/XSL/layout"
  xmlns:upAuth="xalan://org.jasig.portal.security.xslt.XalanAuthorizationHelper"
  xmlns:upGroup="xalan://org.jasig.portal.security.xslt.XalanGroupMembershipHelper"
  xmlns:upMsg="xalan://org.jasig.portal.security.xslt.XalanMessageHelper"
  extension-element-prefixes="portal portlet layout" 
  exclude-result-prefixes="xalan portal portlet layout upAuth upGroup upMsg" 
  version="1.0">
  
  <xalan:component prefix="portal" elements="url param">
    <xalan:script lang="javaclass" src="xalan://org.jasig.portal.url.xml.PortalUrlXalanElements" />
  </xalan:component>
  <xalan:component prefix="portlet" elements="url param">
    <xalan:script lang="javaclass" src="xalan://org.jasig.portal.url.xml.PortletUrlXalanElements" />
  </xalan:component>
  <xalan:component prefix="layout" elements="url param">
    <xalan:script lang="javaclass" src="xalan://org.jasig.portal.url.xml.LayoutUrlXalanElements" />
  </xalan:component>
<!-- ============================================= -->

<!-- ==== TEMPLATE: Gallery Add Portlet Selection ==== -->
<!-- ================================================= -->
<!-- 
| This template renders the add portlet selection view of 
| the gallery. The list of portlets to select from is 
| rendered by a separate template below. Adding a portlet 
| places and persists the portlet into the user's layout.
-->  
    <xsl:template name="gallery-add-content-pane">
        <div class="fl-fix fl-col-mixed fl-col-mixed2 pane add-content">
            <div class="fl-col-fixed fl-force-left content-filters-wrapper">
                <div class="categories-column active">
                    <h3 class="portlet-list-link"><span><xsl:value-of select="upMsg:getMessage('stuff', $USER_LANG)"/></span></h3>
                    <div class="categories-wrapper active">
                    	<div class="portlet-search-view">
                            <form class="portlet-search-form">
                                <label for="portletSearch"><xsl:value-of select="upMsg:getMessage('search.stuff.add', $USER_LANG)"/></label>
                                <input id="portletSearch" name="portletSearch" class="portlet-search-input"/>
                                <input type="submit" value="Search" class="portlet-search-submit"/>
                            </form>
                        </div>
                        <div class="categories">
                            <h4><xsl:value-of select="upMsg:getMessage('categories', $USER_LANG)"/></h4>
                            <ul>
                                <div class="category-choice-container">
                                    <li class="category-choice">
                                        <a href="javascript:;" class="category-choice-link"><span class="category-choice-name"></span></a>
                                    </li>
                                </div>
                            </ul>
                            <div class="clear-float"></div>
                        </div>
                    </div>
                </div>
                <div class="packages-column">
                	<h3 class="package-list-link"><span><xsl:value-of select="upMsg:getMessage('packaged.stuff', $USER_LANG)"/></span></h3>
                    <div class="packages-wrapper">
                        <div class="packages">
                            <p><xsl:value-of select="upMsg:getMessage('add.package.instruction', $USER_LANG)"/></p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="content-results-wrapper fl-col-main">
                <div class="column-inner">
                    <div class="results-wrapper fl-col-mixed2">
                        <div class="pager-column fl-col-side fl-force-right">
                            <div class="column-inner">
                            </div>
                        </div>
                        <div class="results-column fl-col-main fl-fix">
                            <xsl:call-template name="gallery-add-content-pane-portlet-list"/>
                            <xsl:call-template name="gallery-add-content-pane-fragment-list"/>
                        </div>
                        <div class="clear-float"></div>
                    </div>
                </div>
            </div>
            <div class="content-modal content-loading"></div>
        </div>
    </xsl:template>

<!-- ==== TEMPLATE: Gallery Use Portlet Selection ==== -->
<!-- ================================================= -->
<!-- 
| This template renders the use portlet selection view of 
| the gallery. The list of portlets to select from is 
| rendered by a separate template below. Using a portlet 
| does not add the portlet to the user's layout.
-->
    <xsl:template name="gallery-use-content-pane">
        <div class="fl-fix fl-col-mixed fl-col-mixed2 use-content" style="display:none">
            <div class="fl-col-fixed fl-force-left content-filters-wrapper">
                <div class="categories-column active">
                    <h3 class="portlet-list-link"><span><xsl:value-of select="upMsg:getMessage('stuff', $USER_LANG)"/></span></h3>
                    <div class="categories-wrapper active">
                        <div class="portlet-search-view">
                            <form class="portlet-search-form">
                                <div class="search">
                                    <input class="portlet-search-input"/>
                                </div>
                            </form>
                        </div>
                        <div class="categories">
                            <h4><xsl:value-of select="upMsg:getMessage('categories', $USER_LANG)"/></h4>
                            <ul>
                                <div class="category-choice-container">
                                    <li class="category-choice">
                                        <a href="javascript:;" class="category-choice-link"><span class="category-choice-name"></span></a>
                                    </li>
                                </div>
                            </ul>
                            <div class="clear-float"></div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="content-results-wrapper fl-col-main">
                <div class="column-inner">
                    <div class="results-wrapper fl-col-mixed2">
                        <div class="pager-column fl-col-side fl-force-right">
                            <div class="column-inner">
                            </div>
                        </div>
                        <div class="results-column fl-col-main fl-fix">
                            <xsl:call-template name="gallery-add-content-pane-portlet-list"/>
                        </div>
                        <div class="clear-float"></div>
                    </div>
                </div>
            </div>
        </div>
    </xsl:template>    

<!-- ========= TEMPLATE: Gallery Portlet List ======== -->
<!-- ================================================= -->
<!-- 
| This template renders the list of portlets available to 
| both the add portlet and use portlet views of the gallery.
-->    
    <xsl:template name="gallery-add-content-pane-portlet-list">
        <div class="results-wrapper portlet-results fl-col-mixed2">
            <div class="pager-column fl-col-side fl-force-right">
                <div class="column-inner">
                    <xsl:call-template name="gallery-pager"/>
                </div>
            </div>
            <div class="results-column fl-col-main fl-fix">
                <ul class="portlet-list">
                    <li class="portlet">
                        <div class="portlet-wrapper">
                            <a href="javascript:;" class="portlet-link"><span><xsl:value-of select="upMsg:getMessage('add', $USER_LANG)"/></span></a>
                            <div class="portlet-titlebar"></div>
                            <img class="portlet-icon"/>
                            <div class="portlet-description"></div>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </xsl:template>

<!-- == TEMPLATE: Gallery Packaged Portlet Selection = -->
<!-- ================================================= -->
<!-- 
| This template renders the packaged portlet selection 
| view of the gallery.
-->
    <xsl:template name="gallery-add-content-pane-fragment-list">
        <div class="results-wrapper package-results fl-col-mixed2" style="display:none">
            <div class="pager-column fl-col-side fl-force-right">
                <div class="column-inner">
                    <xsl:call-template name="gallery-pager"/>
                </div>
            </div>
            <div class="results-column fl-col-main fl-fix">
                <ul class="package-list">
                    <li class="package">
                       <div class="package-wrapper">
                           <a href="javascript:;" class="package-link"><span><xsl:value-of select="upMsg:getMessage('subscribe', $USER_LANG)"/></span></a>
                           <div class="package-titlebar"></div>
                           <img class="package-icon"/>
                           <div class="package-description"></div>
                       </div>
                    </li>
                </ul>
            </div>
        </div>
    </xsl:template>

<!-- ============= TEMPLATE: Gallery Pagef =========== -->
<!-- ================================================= -->
<!-- 
| This template renders the gallery pager.
-->
    <xsl:template name="gallery-pager">
        <div class="pager flc-pager-top">
            <div class="pager-button-up flc-pager-previous">
                <a class="pager-button-up-inner" href="javascript:;">
                    <span><xsl:value-of select="upMsg:getMessage('up', $USER_LANG)"/></span>
                </a>
            </div>
            <li style="display:none">
                <ul class="fl-pager-links flc-pager-links" style="margin:0; display:inline">
                    <li class="flc-pager-pageLink"><a href="javascript:;">1</a></li>
                    <li class="flc-pager-pageLink-disabled">2</li>
                    <li class="flc-pager-pageLink"><a href="javascript:;">3</a></li>
                </ul>
            </li>
            <div class="pager-pagination"></div>
            <div class="pager-button-down flc-pager-next">
                <a class="pager-button-down-inner" href="javascript:;">
                    <span><xsl:value-of select="upMsg:getMessage('down', $USER_LANG)"/></span>
                </a>
            </div>
            <li style="display:none">
                <span class="flc-pager-summary"><xsl:value-of select="upMsg:getMessage('show', $USER_LANG)"/></span>
                <span><select class="pager-page-size flc-pager-page-size">
                </select></span>
            </li>
        </div>
    </xsl:template>

<!-- ======== TEMPLATE: Gallery Skin Selection ======= -->
<!-- ================================================= -->
<!-- 
| This template renders the skin selection view of the 
| gallery.
-->
    <xsl:template name="gallery-skin-pane">
        <div class="skins" style="display:none">
            <div class="content-results-wrapper">
                <div class="column-inner">
                    <div class="results-wrapper">
                        <ul class="skins-list">
                            <li class="skin">
                                <div class="skins-wrapper">
                                    <a class="skin-link" href="javascript:;">
                                        <div class="skin-titlebar"></div>
                                        <div class="skin-thumb">
                                            <img class="skin-image"/>
                                        </div>
                                    </a>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </xsl:template>
    
<!-- ======= TEMPLATE: Gallery Layout Selection ====== -->
<!-- ================================================= -->
<!-- 
| This template renders the layout selection view of the 
| gallery.
-->
    <xsl:template name="gallery-layout-pane">
        <div class="layouts" style="display:none">
            <div class="content-results-wrapper">
                <div class="column-inner">
                    <div class="results-wrapper">
                        <ul class="layouts-list">
                            <li class="layout">
                                <div class="layout-wrapper">
                                    <a class="layout-link" href="javascript:;">
                                        <div class="layout-titlebar"></div>
                                        <div class="layout-thumb">
                                            <img class="layout-image"/>
                                        </div>
                                        <div class="layout-description"></div>
                                    </a>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </xsl:template>
	
<!-- =============== TEMPLATE: Gallery =============== -->
<!-- ================================================= -->
<!-- 
| This template renders the base structure of the gallery.
| The gallery contains the interfaces for customizing the 
| portal. Individual views presented within the gallery are 
| in separate templates above. Customization options are
| only available to authenticated users.
-->
    <xsl:template name="gallery">
    	<xsl:if test="$AUTHENTICATED = 'true'">
        <div class="up-gallery">
            <h2 class="handle">
                <a><span class="handle-arrow-up">Customize</span></a>
            </h2>
            <div class="fl-fix fl-col-mixed fl-col-mixed2 gallery-inner" style="display:none">
                <div class="fl-col-side fl-force-left menu-wrapper">
                    <ul class="menu" role="menu">
                        <li class="add-content-link active" role="tab">
                            <a href="javascript:;"><span><xsl:value-of select="upMsg:getMessage('add.stuff', $USER_LANG)"/></span></a>
                        </li>
                        <li class="use-content-link" role="tab">
                            <a href="javascript:;"><span><xsl:value-of select="upMsg:getMessage('use.it', $USER_LANG)"/></span></a>
                        </li>
                        <li class="skin-link" role="tab">
                            <a href="javascript:;"><span><xsl:value-of select="upMsg:getMessage('colors', $USER_LANG)"/></span></a>
                        </li>
                        <li class="layout-link last" role="tab">
                            <a href="javascript:;"><span><xsl:value-of select="upMsg:getMessage('layouts', $USER_LANG)"/></span></a>
                        </li>
                    </ul>
                    <div class="close-button">
                        <a><span><xsl:value-of select="upMsg:getMessage('im.done', $USER_LANG)"/></span></a>
                    </div>
                </div>
                <div class="fl-col-main content-wrapper" role="tabpanel">
                    <div class="fl-fix content">
                        <xsl:call-template name="gallery-add-content-pane"/>
                        <xsl:call-template name="gallery-use-content-pane"/>
                        <xsl:call-template name="gallery-skin-pane"/>
                        <xsl:call-template name="gallery-layout-pane"/>
                    </div>
                    <div class="content-modal gallery-loading"></div>
                </div>
            </div>
        </div>
        </xsl:if>
    </xsl:template>

 <xsl:template name="preferences">
  
  <xsl:choose>
   
   <xsl:when test="//focused[@in-user-layout='no'] and upGroup:isChannelDeepMemberOf(//focused/channel/@fname, 'local.1')">
    <div id="ajaxMenus" style="display:none;">
        <!-- Add Channel Menu -->
        <div class="focused-content-dialog"
            title="{$TOKEN[@name='AJAX_ADD_FOCUSED_PORTLET_DIALOG_TITLE']}">
            <form>
                <fieldset>
                    <legend>
                        <xsl:value-of
                            select="$TOKEN[@name='AJAX_ADD_PORTLET_TO_LAYOUT']" />
                    </legend>
                    <xsl:for-each select="/layout/navigation/tab">
                        <input name="targetTab" id="targetTab{@ID}"
                            value="{@ID}" type="radio" />
                        <label for="targetTab{@ID}" class="portlet-form-field-label">
                            <xsl:value-of select="@name" />
                        </label>
                        <br />
                    </xsl:for-each>
                </fieldset>
                <p>
                    <input name="portletId" type="hidden"
                        value="{//focused/channel/@chanID}" />
                    <input type="submit"
                        value="{$TOKEN[@name='AJAX_ADD_FOCUSED_PORTLET_SUBMIT_BUTTON']}"
                        class="portlet-form-button" />
                    &#160;
                </p>
            </form>
        </div>
    </div>
    <script type="text/javascript">
        up.jQuery(document).ready(function(){
            up.FocusedLayoutPreferences(
                "body",
                {
                    portalContext: '<xsl:value-of select="$CONTEXT_PATH"/>',
                    layoutPersistenceUrl: '<xsl:value-of select="$CONTEXT_PATH"/>/mvc/layout',
                }
            );
        });
    </script>
   </xsl:when>
   
   <xsl:when test="not(//focused)">
  
    <div id="dojoMenus" class="dialogs" style="display:none;">
           
     <xsl:if test="$IS_FRAGMENT_ADMIN_MODE='true'">
     
         <div class="edit-page-permissions-dialog" title="Edit Page Permissions">
            <div class="fl-widget portlet">
                <div class="fl-widget-titlebar titlebar portlet-titlebar" role="sectionhead">
                    <h2 class="title" role="heading"><xsl:value-of select="/layout/navigation/tab[@activeTab='true']/@name"/></h2>
                </div>
            
                <div class="fl-widget-content content portlet-content" role="main">
                    <div class="portlet-section" role="region">
                        <div class="titlebar">
                            <h3 class="title" role="heading">Allow users to:</h3>
                        </div>
                        <div class="content">
                            <form>
                                <p>
                                    <input type="hidden" name="nodeId" value="{/layout/navigation/tab[@activeTab='true']/@ID}"/>
                                    <input type="checkbox" name="movable"/> Move this page<br />
                                    <input type="checkbox" name="editable"/> Edit page properties<br />
                                    <input type="checkbox" name="addChildAllowed"/> Add columns<br />
                                    <input type="checkbox" name="deletable"/> Delete this page<br />
                                </p>
                            
                                <div class="buttons">
                                    <input type="submit" class="button primary portlet-form-button" value="Update Permissions"/>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
             </div>
         </div>
         
         <div class="edit-column-permissions-dialog" title="Edit Column Permissions">
            <div class="fl-widget portlet">
                <div class="fl-widget-titlebar titlebar portlet-titlebar" role="sectionhead">
                    <h2 class="title" role="heading"></h2>
                </div>
            
                <div class="fl-widget-content content portlet-content" role="main">
                    <form>
                        <p>Allow users to:</p>
                        <p>
                            <input type="hidden" name="nodeId" value=""/>
                            <input type="checkbox" name="movable"/> Move this column<br />
                            <input type="checkbox" name="editable"/> Edit column properties<br />
                            <input type="checkbox" name="addChildAllowed"/> Add portlets to this column<br />
                            <input type="checkbox" name="deletable"/> Delete this column<br />
                        </p>
                        
                        <div class="buttons">
                            <input type="submit" class="button primary portlet-form-button" value="Update Permissions"/>
                        </div>
                    </form>
                </div>
            </div>
         </div>
         
         <div class="edit-portlet-permissions-dialog" title="Edit Portlet Permissions">
            <div class="fl-widget portlet">
                <div class="fl-widget-titlebar titlebar portlet-titlebar" role="sectionhead">
                    <h2 class="title" role="heading"></h2>
                </div>
            
                <div class="fl-widget-content content portlet-content" role="main">
                    <div class="portlet-section" role="region">
                        <div class="titlebar">
                            <h3 class="title" role="heading">Allow users to:</h3>
                        </div>
                        <div class="content">
                            <form>
                                <p>
                                    <input type="hidden" name="nodeId"/>
                                    <input type="checkbox" name="movable"/> Move this portlet<br />
                                    <input type="checkbox" name="deletable"/> Delete this portlet<br />
                                </p>
                                
                                <div class="buttons">
                                    <input type="submit" class="button primary portlet-form-button" value="Update Permissions"/>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
         </div>
     </xsl:if>
    
     <div id="portalDropWarning" style="display:none;">
      <p><xsl:value-of select="$TOKEN[@name='AJAX_PORTAL_DROP_WARNING_MESSAGE']"/></p>
     </div>
     
    </div>
    <script type="text/javascript">
       up.jQuery(document).ready(function(){
          up.jQuery.uportal.UportalLayoutManager(
            {
              portalUrl: '<portal:url/>',
              mediaPath: '<xsl:value-of select="$ABSOLUTE_MEDIA_PATH"/>',
              currentSkin: '<xsl:value-of select="$SKIN"/>',
              subscriptionsSupported: '<xsl:value-of select="$subscriptionsSupported"/>',
              preferencesUrl: '<xsl:value-of select="$CONTEXT_PATH"/>/mvc/layout',
              channelListUrl: '<xsl:value-of select="$CONTEXT_PATH"/>/mvc/channelList',
              subscriptionListUrl: '<xsl:value-of select="$CONTEXT_PATH"/>/mvc/tabList',
              isFragmentMode: <xsl:choose><xsl:when test="$IS_FRAGMENT_ADMIN_MODE='true'">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>,
              messages: { 
                  confirmRemoveTab: '<xsl:value-of select="$TOKEN[@name='AJAX_REMOVE_TAB_CONFIRMATION_MESSAGE']"/>', 
                  confirmRemovePortlet: '<xsl:value-of select="$TOKEN[@name='AJAX_REMOVE_PORTLET_CONFIRMATION_MESSAGE']"/>' 
              }
            }
          );
          up.LayoutPreferences(
            "body",
            {
              pageUrl: '<portal:url/>',
              portalContext: '<xsl:value-of select="$CONTEXT_PATH"/>',
              mediaPath: '<xsl:value-of select="$ABSOLUTE_MEDIA_PATH"/>',
              currentSkin: '<xsl:value-of select="$SKIN"/>',
              subscriptionsSupported: '<xsl:value-of select="$subscriptionsSupported"/>',
              layoutPersistenceUrl: '<xsl:value-of select="$CONTEXT_PATH"/>/mvc/layout',
              channelRegistryUrl: '<xsl:value-of select="$CONTEXT_PATH"/>/mvc/channelList',
              subscribableTabUrl: '<xsl:value-of select="$CONTEXT_PATH"/>/mvc/tabList',
              messages: { 
                  confirmRemoveTab: '<xsl:value-of select="$TOKEN[@name='AJAX_REMOVE_TAB_CONFIRMATION_MESSAGE']"/>', 
                  confirmRemovePortlet: '<xsl:value-of select="$TOKEN[@name='AJAX_REMOVE_PORTLET_CONFIRMATION_MESSAGE']"/>' 
              }
            }
          );
       });
    </script>
      
   </xsl:when>
  </xsl:choose>
 </xsl:template>
 
</xsl:stylesheet>
