import { LightningElement, track, wire } from 'lwc';
import parseFileBody from '@salesforce/apex/FileUploadHelper.parseFileBody';


export default class PalindromeParent extends LightningElement {
    @track documentId;
    @track documentBody;

    @wire(parseFileBody, {documentId: '$documentId'})
    wiredDocumentBody({data, error}){
        if(data){
            this.error = undefined;
            this.documentBody = data;
        } else if (error){
            this.error = error;
            this.documentBody = undefined;   
        }
    }

    handleDocIdEvent(event){
        console.log('event received');
        this.documentId = event?.detail && event?.detail?.value;   
    }

}