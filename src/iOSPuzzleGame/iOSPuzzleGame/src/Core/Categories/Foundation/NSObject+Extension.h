#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>

@interface NSObject (Extension)

- (void) printClassHieararhy;

- (BOOL) isNumber;
- (BOOL) isString;
- (BOOL) isDictionary;
- (BOOL) isArray;
- (BOOL) isDate;
- (BOOL) isData;

+ (NSString *)className;
- (NSString *)className;

- (id) castToClass:(Class)aClass;

// used when other type or nil value of object is within normal application logic e.g. just to choose one of possible types
+ (id) castObject:(NSObject *)object;

// used when other type or nil value of object is not normal - in this caseassertion will occure
+ (id) assertCastObject:(NSObject *)object;

// used when valid object must be returned in any case: for other type or nil value of object given default object will be returned
+ (id) castObject:(NSObject *)object or:(id)defaultObject;


+ (id) memberObject:(NSObject *)object;
+ (BOOL) isClassOfObject:(id)obj;


@end
