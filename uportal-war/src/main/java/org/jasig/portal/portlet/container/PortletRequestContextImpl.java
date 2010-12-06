/**
 * Licensed to Jasig under one or more contributor license
 * agreements. See the NOTICE file distributed with this work
 * for additional information regarding copyright ownership.
 * Jasig licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file
 * except in compliance with the License. You may obtain a
 * copy of the License at:
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on
 * an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

package org.jasig.portal.portlet.container;

import java.util.Collections;
import java.util.Enumeration;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.portlet.PortletConfig;
import javax.portlet.PortletRequest;
import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.pluto.container.PortletContainer;
import org.apache.pluto.container.PortletRequestContext;
import org.apache.pluto.container.driver.PortletServlet;
import org.jasig.portal.portlet.container.properties.IRequestPropertiesManager;
import org.jasig.portal.portlet.om.IPortletWindow;
import org.jasig.portal.portlet.rendering.IPortletRenderer;
import org.jasig.portal.url.AbstractHttpServletRequestWrapper;
import org.jasig.portal.url.IPortalRequestInfo;
import org.jasig.portal.url.IPortletRequestInfo;
import org.jasig.portal.url.ParameterMap;
import org.jasig.portal.utils.FilteringEnumeration;
import org.springframework.util.Assert;

/**
 * Backs the {@link PortletRequest} impl provided by Pluto 
 * 
 * @author Eric Dalquist
 * @version $Revision$
 */
public class PortletRequestContextImpl extends AbstractPortletContextImpl implements PortletRequestContext {
    private final Map<String, Object> attributes = new LinkedHashMap<String, Object>();
    
    protected final IRequestPropertiesManager requestPropertiesManager;
    protected final IPortalRequestInfo portalRequestInfo;
    
    //Objects provided by the PortletServlet via the init method
    //The servlet objects are from the scope of the cross-context dispatch
    protected PortletConfig portletConfig;
    protected ServletContext servletContext;
    
    public PortletRequestContextImpl(
            PortletContainer portletContainer, IPortletWindow portletWindow,
            HttpServletRequest containerRequest, HttpServletResponse containerResponse,
            IRequestPropertiesManager requestPropertiesManager, IPortalRequestInfo portalRequestInfo) {
        
        super(portletContainer, portletWindow, containerRequest, containerResponse);
        
        Assert.notNull(requestPropertiesManager, "requestPropertiesManager cannot be null");
        Assert.notNull(portalRequestInfo, "portalRequestInfo cannot be null");

        this.requestPropertiesManager = requestPropertiesManager;
        this.portalRequestInfo = portalRequestInfo;
    }

    /**
     * Called by {@link PortletServlet} after the cross context dispatch but before the portlet invocation
     * 
     * @see org.apache.pluto.container.PortletRequestContext#init(javax.portlet.PortletConfig, javax.servlet.ServletContext, javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
     */
    @Override
    public void init(PortletConfig portletConfig, ServletContext servletContext, HttpServletRequest servletRequest, HttpServletResponse servletResponse) {
        Assert.notNull(portletConfig, "portletConfig cannot be null");
        Assert.notNull(servletContext, "servletContext cannot be null");

        super.init(servletRequest, servletResponse);
        
        this.portletConfig = portletConfig;
        this.servletContext = servletContext;
    }

    /* (non-Javadoc)
     * @see org.apache.pluto.container.PortletRequestContext#getPortletConfig()
     */
    @Override
    public PortletConfig getPortletConfig() {
        return this.portletConfig;
    }

    /* (non-Javadoc)
     * @see org.apache.pluto.container.PortletRequestContext#getServletContext()
     */
    @Override
    public ServletContext getServletContext() {
        return this.servletContext;
    }

    /* (non-Javadoc)
     * @see org.apache.pluto.container.PortletRequestContext#getAttribute(java.lang.String)
     */
    @Override
    public Object getAttribute(String name) {
        if (name.startsWith(IPortletRenderer.RENDERER_ATTRIBUTE_PREFIX)) {
            return null;
        }
        
        final Object attribute = this.attributes.get(name);
        if (attribute != null) {
            return attribute;
        }
        
        if (name.startsWith(AbstractHttpServletRequestWrapper.PORTAL_ATTRIBUTE_PREFIX)) {
            return this.servletRequest.getAttribute(name);
        }
        
        if(name.equals(PortletRequest.RENDER_PART)) {
        	return this.servletRequest.getAttribute(name);
        }
        
        return null;
    }

    /* (non-Javadoc)
     * @see org.apache.pluto.container.PortletRequestContext#getAttributeNames()
     */
    @Override
    @SuppressWarnings("unchecked")
    public Enumeration<String> getAttributeNames() {
        return Collections.enumeration(this.attributes.keySet());
    }

    /* (non-Javadoc)
     * @see org.apache.pluto.container.PortletRequestContext#setAttribute(java.lang.String, java.lang.Object)
     */
    @Override
    public void setAttribute(String name, Object value) {
        if (name.startsWith(IPortletRenderer.RENDERER_ATTRIBUTE_PREFIX)) {
            throw new IllegalArgumentException("Portlets cannot set attributes that start with: " + IPortletRenderer.RENDERER_ATTRIBUTE_PREFIX);
        }

        this.attributes.put(name, value);
    }

    /* (non-Javadoc)
     * @see org.apache.pluto.container.PortletRequestContext#getCookies()
     */
    @Override
    public Cookie[] getCookies() {
        //TODO cookie support
        return new Cookie[0];
    }

    /* (non-Javadoc)
     * @see org.apache.pluto.container.PortletRequestContext#getPreferredLocale()
     */
    @Override
    public Locale getPreferredLocale() {
        return this.servletRequest.getLocale();
    }

    /* (non-Javadoc)
     * @see org.apache.pluto.container.PortletRequestContext#getPrivateParameterMap()
     */
    @Override
    public Map<String, String[]> getPrivateParameterMap() {
        final IPortletRequestInfo portletRequestInfo = this.portalRequestInfo.getPortletRequestInfo();
        if (portletRequestInfo != null && this.portletWindow.getPortletWindowId().equals(portletRequestInfo.getTargetWindowId())) {
            final Map<String, List<String>> portletParameters = portletRequestInfo.getPortletParameters();
            return ParameterMap.convertListMap(portletParameters);
        }
        return this.portletWindow.getPreviousPrivateRenderParameters();
    }

    /* (non-Javadoc)
     * @see org.apache.pluto.container.PortletRequestContext#getProperties()
     */
    @Override
    public Map<String, String[]> getProperties() {
        return this.requestPropertiesManager.getRequestProperties(this.servletRequest, this.portletWindow);
    }

    /* (non-Javadoc)
     * @see org.apache.pluto.container.PortletRequestContext#getPublicParameterMap()
     */
    @Override
    public Map<String, String[]> getPublicParameterMap() {
        final IPortletRequestInfo portletRequestInfo = this.portalRequestInfo.getPortletRequestInfo();
        if (portletRequestInfo != null) {
            final Map<String, List<String>> portletParameters = portletRequestInfo.getPublicPortletParameters();
            return ParameterMap.convertListMap(portletParameters);
        }
        return this.portletWindow.getPreviousPublicRenderParameters();
    }

}