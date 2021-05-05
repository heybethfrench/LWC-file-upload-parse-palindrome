import { LightningElement } from 'lwc';

export default class FileUploadExample extends LightningElement {

    get acceptedFormats() {
        return ['.txt'];
    }

    handleUploadFinished(event) {
        
        // Get the list of uploaded files
        const uploadedFiles = event.detail.files;
        
        const DocIdEvent = new CustomEvent('docidsend', {detail : {value : uploadedFiles[0].documentId}});
        this.dispatchEvent(DocIdEvent);

    }
    
}
