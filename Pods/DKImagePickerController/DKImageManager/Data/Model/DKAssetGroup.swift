//
//  DKAssetGroup.swift
//  DKImagePickerControllerDemo
//
//  Created by ZhangAo on 15/12/13.
//  Copyright © 2015年 ZhangAo. All rights reserved.
//

import Photos

// Group Model
public class DKAssetGroup : NSObject {
	@objc public var groupId: String!
	@objc public var groupName: String!
	public var totalCount: Int!
	
	@objc public var originalCollection: PHAssetCollection!
	@objc public var fetchResult: PHFetchResult<PHAsset>!
}
