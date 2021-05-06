public with sharing class FileUploadHelper {

    //retrieves the document body of the file that was uploaded, and returns a List of Data Wrappers -- one for each palindrome
    @AuraEnabled(cacheable=true)
    public static List<PalWrapper> parseFileBody(String documentId){
        
        ContentVersion myContent = [SELECT VersionData 
                                    FROM ContentVersion 
                                    WHERE ContentDocumentId = :documentId
                                    AND IsLatest = true LIMIT 1];

        List<String> docBody = myContent.VersionData.toString().split('\n');
        List<PalWrapper> palWrapperList = new List<PalWrapper>(); 

        if(docBody != null){
            for(String sentence : docBody){ 
                Integer key = 0;
                if(isPalindrome(sentence)){
                    List<abcWrapper> letterCounts = createLetterMap(sentence.replaceAll('[^a-zA-Z0-9\\s+]', '').toLowerCase().deleteWhitespace());
                    palWrapperList.add(new PalWrapper(key, sentence, letterCounts));
                    key = key + 1;
                }     
            }
        }
        return palWrapperList;
    }

    //function that determines if a string is a palindrome
    public static Boolean isPalindrome(String s){
        String newString = s.replaceAll('[^a-zA-Z0-9\\s+]', '').toLowerCase().deleteWhitespace();
        String revString = newString.reverse();
        return newString == revString;
    }

    //function that creates a Map of statistical data re: letter occurance in any given string
    public static List<abcWrapper> createLetterMap(String palindrome){
        System.debug('in the letter map function');
        List<abcWrapper> abcWrapList = new List<abcWrapper>();
        Map<String, Integer> letterMap = new Map<String, Integer>(); 
        List<String> palCharList = palindrome.split('');
        List<String> abcList = 'abcdefghijklmnopqrstuvwxyz'.split('');        
          

        for(String letter : abcList){
            letterMap.put(letter, 0);
        }

        for(String palChar : palCharList){
            if(letterMap.get(palChar) == null){
                letterMap.put(palChar, 1);
            }
            letterMap.put(palChar, letterMap.get(palchar) +1);
            
        }

        Integer Id = 0;
        for(String key : letterMap.keySet()){
            abcWrapList.add(new abcWrapper(Id, key, letterMap.get(key)));
        }

        return abcWrapList;

    }

    public class PalWrapper {
		@AuraEnabled 
		public String palindrome {get;set;}
		@AuraEnabled
		public List<abcWrapper> abcAnalysis {get;set;}
        @AuraEnabled
		public Integer wrapperKey {get;set;}
     
		public PalWrapper(Integer theKey, String thePalindrome, List<abcWrapper> theAbcAnalysis) {
            this.wrapperKey = theKey;
            this.palindrome = thePalindrome;
            this.abcAnalysis = theAbcAnalysis;
            
		}
	} 

    public class abcWrapper{
        @AuraEnabled
        public Integer abcWrapId {get;set;}
        @AuraEnabled
        public String key {get;set;}
        @AuraEnabled
        public Integer value {get;set;}

        public abcWrapper(Integer theId, String theKey, Integer theValue){
            this.abcWrapId = theId;
            this.key = theKey;
            this.value = theValue;
        }
    }
}
