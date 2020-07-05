package org.apache.ofbiz.services;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ofbiz.base.util.Debug;
import org.apache.ofbiz.entity.Delegator;
import org.apache.ofbiz.entity.GenericEntityException;
import org.apache.ofbiz.entity.GenericValue;
import org.apache.ofbiz.entity.util.EntityQuery;
import org.apache.ofbiz.product.category.CategoryServices;
import org.apache.ofbiz.service.DispatchContext;
import org.apache.ofbiz.service.GenericServiceException;
import org.apache.ofbiz.service.LocalDispatcher;
import org.apache.ofbiz.service.ServiceUtil;

public class RetailServices {

	public static final String module = CategoryServices.class.getName();
    public static final String resourceError = "ProductErrorUiLabels";
	
	@SuppressWarnings("unchecked")
	public static Map<String, Object> getRetailCategoryMembers(DispatchContext dctx, Map<String, ? extends Object> context) {
        Delegator delegator = dctx.getDelegator();
        String productCategoryTypeId = (String) context.get("productCategoryTypeId");
        Map<String, Object> param = new HashMap<String, Object>();
        Map<String, Object> productCategoriesWithProducts = new HashMap<String, Object>();
		try {
			List<GenericValue> productCategories = EntityQuery.use(delegator).from("ProductCategory").where("productCategoryTypeId", productCategoryTypeId).cache(false).queryList();
			for(GenericValue gv : productCategories) {
				param = new HashMap<String, Object>();
				System.out.println("categoryId => "+ gv.get("productCategoryId"));
				List<GenericValue> productsList = EntityQuery.use(delegator).from("ProductCategoryAndProductDetails").where("productCategoryId", gv.get("productCategoryId")).cache(false).queryList();
				productCategoriesWithProducts.put((String)gv.get("productCategoryId"),productsList);
			}
        	if (Debug.verboseOn()) Debug.logVerbose("Total "+productCategories.size() +" Category retrived for Product Category Type Id "+productCategoryTypeId +" and respective products.", module);
        } catch (GenericEntityException e) {
        	return ServiceUtil.returnError(e.getMessage());
        }
        Map<String, Object> result = ServiceUtil.returnSuccess();
        result.put("status", "success");
        result.put("productCategoriesWithProducts", productCategoriesWithProducts);
        return result;
    }

}
