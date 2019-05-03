//
/****************************************************************************
 * Copyright 2019, Optimizely, Inc. and contributors                        *
 *                                                                          *
 * Licensed under the Apache License, Version 2.0 (the "License");          *
 * you may not use this file except in compliance with the License.         *
 * You may obtain a copy of the License at                                  *
 *                                                                          *
 *    http://www.apache.org/licenses/LICENSE-2.0                            *
 *                                                                          *
 * Unless required by applicable law or agreed to in writing, software      *
 * distributed under the License is distributed on an "AS IS" BASIS,        *
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. *
 * See the License for the specific language governing permissions and      *
 * limitations under the License.                                           *
 ***************************************************************************/


import Foundation
import Optimizely

class SamplesForAPI {
    
    static func run(optimizely: OptimizelyClient) {
        
        let attributes: [String: Any] = [
            "device": "iPhone",
            "lifetime": 24738388,
            "is_logged_in": true,
            ]
        let tags: [String: Any] = [
            "category": "shoes",
            "count": 2,
            ]
        
        if let variationKey = try? optimizely.activate(experimentKey: "my_experiment_key",
                                                       userId: "user_123",
                                                       attributes: attributes) {
            print("[activate] \(variationKey)")
        }
        
        if let variationKey = try? optimizely.getVariationKey(experimentKey: "my_experiment_key",
                                                              userId: "user_123",
                                                              attributes: attributes) {
            print("[getVariationKey] \(variationKey)")
        }
        
        if let variationKey = optimizely.getForcedVariation(experimentKey: "my_experiment_key", userId: "user_123") {
            print("[getForcedVariation] \(variationKey)")
        }
        
        if optimizely.setForcedVariation(experimentKey: "my_experiment_key",
                                         userId: "user_123",
                                         variationKey: "some_variation_key") {
            print("[setForcedVariation]")
        }
        
        do {
            let enabled = try optimizely.isFeatureEnabled(featureKey: "my_feature_key",
                                                          userId: "user_123",
                                                          attributes: attributes)
            print("[isFeatureEnabled] \(enabled)")
        } catch {
            // error
        }
        
        if let featureVariableValue = try? optimizely.getFeatureVariableDouble(featureKey: "my_feature_key",
                                                                               variableKey: "double_variable_key",
                                                                               userId: "user_123",
                                                                               attributes: attributes) {
            print("[getFeatureVariableDouble] \(featureVariableValue)")
        }
        
        if let enabledFeatures = try? optimizely.getEnabledFeatures(userId: "user_123", attributes: attributes) {
            print("[getEnabledFeatures] \(enabledFeatures)")
        }
        
        try? optimizely.track(eventKey: "my_purchase_event_key", userId: "user_123", attributes: attributes, eventTags: tags)
        print("[track]")
    }
    
    
}
