//
//  AnotacaoViewController.swift
//  NotesDayApp
//
//  Created by João Ricardo Martins Ribeiro on 05/12/24.
//

import UIKit
import CoreData

class AnotacaoViewController: UIViewController {

    @IBOutlet weak var texto: UITextView!
    var context : NSManagedObjectContext!
    var anotacao : NSManagedObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // configuracoes iniciais
        self.texto.becomeFirstResponder()
        
        if anotacao != nil {
            if let textoRecuperado = anotacao.value(forKey: "texto") {
                self.texto.text = String(describing: textoRecuperado)
            }
        }else{
            self.texto.text = ""
        }

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    @IBAction func salvar(_ sender: Any) {
        if anotacao != nil {
            self.atualizarAnotacao()
        }else{
            self.salvarAnotacao()
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func atualizarAnotacao() {
        // configura anotacao
        anotacao.setValue(self.texto.text, forKey: "texto")
        anotacao.setValue(Date(), forKey: "data")
        
        do {
            try context.save()
            print("Sucesso ao atualizar anotação!")
        } catch let erro {
            print("Erro ao atualizar anotação: \(erro.localizedDescription)")
        }
    }
    
    func salvarAnotacao() {
        // cria objeto para anotaçao
        let novaAnotacao = NSEntityDescription.insertNewObject(forEntityName: "Anotacao", into: context)
        
        // configura anotacao
        novaAnotacao.setValue(self.texto.text, forKey: "texto")
        novaAnotacao.setValue(Date(), forKey: "data")
        
        do {
            try context.save()
            print("Sucesso ao salvar anotação!")
        } catch let erro {
            print("Erro ao salvar anotação: \(erro.localizedDescription)")
        }
    }
}
