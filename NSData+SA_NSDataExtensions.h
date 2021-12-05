//
//  NSData+SA_NSDataExtensions.h
//
//  Copyright 2015-2021 Said Achmiz.
//  See LICENSE and README.md for more info.

#import <Foundation/Foundation.h>

/** \category NSData+SA_NSDataExtensions
 *	@brief Adds several utility methods to NSData.
 */
@interface NSData (SA_NSDataExtensions)

//	NOTE on stripping nulls from the ends of byte arrays.
//
//	If you strip a null from the end of an array which is something other than
//	a null-terminated C string (such as, for example, the bytes representing a
//	UTF-16 string), and thereby cause yourself difficulties, you have only
//	yourself to blame. Be sure that you know what your NSData objects are 
//	supposed to contain!

/**	Returns YES if the last byte of the stored data is null, NO otherwise.
 */
@property (readonly, getter=isNullTerminated) BOOL nullTerminated;

/** Returns the stored bytes as a null-terminated C string (byte array).
	
	If the stored data is already null-terminated, the returned pointer will
	be a pointer to the bytes managed by the receiver. If it is not already
	null-terminated, the returned pointer will point to bytes managed by a 
	copy of the receiver (and the bytes of the copy will be null-terminated).
 */
@property (readonly) const char *terminatedCString;

/**	Returns data containing the stored bytes as a null-terminated C string
	(byte array).
	
	If the stored data is already null-terminated, this method simply returns
	the receiver. If it is not already null-terminated, this method returns a 
	reference to a fresh copy of the receiver (a copy that contains a 
	null-terminated byte array, of course).
 */
@property (readonly) NSData *dataWithTerminatedCString;

/** Returns an NSData object containing a blank C string (i.e. a byte sequence
	of length 1, containing the null character '\0').
 */
+(NSData *) dataWithBlankCString;

/** Returns an NSData object containing bytes copied from the given C string
	(sans the null terminator).
 */
+(NSData *) dataFromCString:(const char *)cString;

/** Returns an NSData object containing the bytes of the given C string
	(sans the null terminator).
 */
+(NSData *) dataWithCString:(char *)cString;

@end
