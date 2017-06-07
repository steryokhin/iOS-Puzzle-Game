#import "NSObject+Extension.h"

typedef float (*FloatReturnObjCMsgSendFunction)(id,SEL);
typedef int (*IntReturnObjCMsgSendFunction)(id,SEL);

@implementation NSObject (Extension)

- (void) printClassHieararhy {
	Class currentClass = [self class];
	NSMutableArray *arr = [NSMutableArray arrayWithCapacity:10];
	
	while (currentClass != nil) {
		[arr addObject:currentClass];
		currentClass = [currentClass superclass];
	}
}

- (BOOL) isNumber {
	return [self isKindOfClass:[NSNumber class]];
}

- (BOOL) isString {
	return [self isKindOfClass:[NSString class]];	
}

- (BOOL) isDictionary {
	return [self isKindOfClass:[NSDictionary class]];
}

- (BOOL) isArray {
	return [self isKindOfClass:[NSArray class]];	
}

- (BOOL) isDate {
	return [self isKindOfClass:[NSDate class]];	
}

- (BOOL) isData {
	return [self isKindOfClass:[NSData class]];	
}

+ (NSString *)className{
    return NSStringFromClass([self class]);
}

- (NSString *)className{
    return NSStringFromClass([self class]);
}

- (id) castToClass:(Class)aClass{
    if ([self isKindOfClass:aClass]){
        return self;
    }
    return nil;
}

- (id) castToExactClass:(Class)aClass{
    if ([self isMemberOfClass:aClass]){
        return self;
    }
    return nil;
}

+ (id) castObject:(NSObject *)object{
    if ([object isKindOfClass:self]){
        return object;
    }
    return nil;
}

+ (id) assertCastObject:(NSObject *)object{
    if (object == nil){
        return nil;
    }
    if ([object isKindOfClass:self]){
        return object;
    }

    NSAssert(0, @"Attempt to cast to wrong type");
    return nil;
}

+ (id) castObject:(NSObject *)object or:(id)defaultObject{
    if ([object isKindOfClass:self]){
        return object;
    }
    return defaultObject;
}

+ (id) memberObject:(NSObject *)object{
    if ([object isMemberOfClass:self]){
        return object;
    }
    return nil;
}

+ (BOOL) isClassOfObject:(id)obj{
    return [obj isKindOfClass:self];
}

@end
